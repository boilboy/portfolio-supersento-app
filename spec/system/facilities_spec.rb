# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Facilities（施設機能）', type: :system do
  describe '施設一覧画面・検索・ページネーション・ソート機能' do
    let!(:facility_tokyo) { create(:facility, :tokyo) }
    let!(:facility_yokohama) { create(:facility, :yokohama) }
    let!(:facility_chiba) { create(:facility, :chiba) }

    context '初期表示かつページ制限がない場合' do
      it 'すべての施設一覧が正しく表示され、ページネーションリンクがないこと' do
        visit facilities_path
        expect_total_count(3)
        expect_only_visible_facilities(facility_tokyo, facility_yokohama, facility_chiba)
        expect(page).not_to have_selector('button.bg-primary', text: '1')
        expect(page).not_to have_link(text: 'chevron_right')
        expect(page).not_to have_link(text: 'chevron_left')
      end
    end

    context 'データ件数が表示制限を超えてページネーションが発生する場合' do
      before { stub_const('FacilitiesController::FACILITIES_COUNT', 2) }

      it '次へのページ遷移ボタンをクリックして2ページ目の情報が表示され、適したページネーションリンクがあること' do
        visit facilities_path

        find('a[rel="next"]', text: 'chevron_right').click

        expect(page).to have_selector('button.bg-primary', text: '2')
        expect_total_count(3)
        expect_only_visible_facilities(facility_chiba)
        expect(page).to have_link(text: 'chevron_left')
        expect(page).not_to have_link(text: 'chevron_right')
      end

      it '前のページへの遷移ボタンをクリックして1ページ目の情報が表示され、適したページネーションリンクがあること' do
        visit facilities_path
        find('a[rel="next"]', text: 'chevron_right').click
        find('a[rel="prev"]', text: 'chevron_left').click

        expect(page).to have_selector('button.bg-primary', text: '1')
        expect_total_count(3)
        expect_only_visible_facilities(facility_tokyo, facility_yokohama)
        expect(page).to have_link(text: 'chevron_right')
        expect(page).not_to have_link(text: 'chevron_left')
      end
    end

    context 'キーワード検索を行う場合(ページネーションなし)' do
      it '検索ワードに一致した施設がある場合、該当する検索結果が表示されること' do
        visit facilities_path

        search_for('街中')
        expect_only_visible_facilities(facility_tokyo)
        expect_total_count(1)
      end

      it '検索ワードに一致した施設がない場合、専用のノーマッチ画面が表示されること' do
        visit facilities_path

        search_for('存在しない絶対ない施設名')
        expect_total_count(0)
        expect_only_visible_facilities
        expect(page).to have_content('該当する施設が見つかりませんでした')
        expect(page).to have_content('別のキーワードでお試しください。')
      end
    end

    context 'キーワード検索を行う場合(ページネーションあり)' do
      before { stub_const('FacilitiesController::FACILITIES_COUNT', 1) }

      it '検索結果の2ページ目に遷移した際に、検索条件と入力ワードが維持されていること' do
        visit facilities_path

        search_for('施設')

        expect(page).to have_selector('button.bg-primary', text: '1')
        expect(page).to have_field('q[keyword]', with: '施設')
        expect_only_visible_facilities(facility_tokyo)

        find('a[rel="next"]', text: 'chevron_right').click

        expect(page).to have_selector('button.bg-primary', text: '2')
        expect_total_count(3)
        expect(page).to have_field('q[keyword]', with: '施設')
        expect_only_visible_facilities(facility_yokohama)
      end
    end

    context 'ソート機能単体を検証する場合' do
      it 'プルダウンを切り替えた際、料金の安い順に正しく並び替わること' do
        visit facilities_path

        find('select.w-full').select('料金の安い順')

        expect_total_count(3)
        expect(page).to have_content(facility_chiba.name)
        expect(page.text).to match(/#{facility_chiba.name}.*#{facility_yokohama.name}.*#{facility_tokyo.name}/m)
      end
    end

    context '検索·ページネーション·ソート·全て連動連動させる場合' do
      before { stub_const('FacilitiesController::FACILITIES_COUNT', 1) }

      it 'キーワード検索してからソート順をクリックして、適したページネーションで表示されること' do
        visit facilities_path

        search_for('施設')
        expect_only_visible_facilities(facility_tokyo)

        find('select.w-full').select('料金の安い順')
        expect_only_visible_facilities(facility_chiba)

        find('a[rel="next"]', text: 'chevron_right').click

        expect(page).to have_selector('button.bg-primary', text: '2')
        expect_total_count(3)
        expect(page).to have_field('q[keyword]', with: '施設')
        expect(page).to have_select(with_options: ['料金の安い順'])
        expect_only_visible_facilities(facility_yokohama)

        expect(page).to have_link(text: 'chevron_left')
        expect(page).to have_link(text: 'chevron_right')
      end
    end

    context '各種外部動線から誘導される場合' do
      it 'ヘッダーの「施設を探す」をクリックした際、通常の施設一覧画面に正しく誘導されること' do
        visit root_path
        click_link '施設を探す'

        expect(page).to have_current_path(facilities_path, ignore_query: false)
        expect(page).to have_css('a.text-primary.font-bold', text: '施設を探す')
        expect_only_visible_facilities(facility_tokyo, facility_yokohama, facility_chiba)
      end

      it 'ヘッダーの「人気ランキング」をクリックした際、評価の高い順の一覧画面に正しく誘導されること' do
        visit root_path
        click_link '人気ランキング'

        expect(page).to have_current_path(facilities_path(q: { s: 'average_rating desc' }), ignore_query: false)
        expect(page).to have_css('a.text-primary.font-bold', text: '人気ランキング')
        expect_only_visible_facilities(facility_tokyo, facility_yokohama, facility_chiba)
      end

      it 'トップページの「すべて見る」リンクをクリックした際、通常の施設一覧画面に正しく誘導されること' do
        visit root_path
        click_link 'すべて見る'

        expect(page).to have_current_path(facilities_path, ignore_query: false)
        expect_only_visible_facilities(facility_tokyo, facility_yokohama, facility_chiba)
      end
    end
  end
end
