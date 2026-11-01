# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe '.search_vacancies' do
    let!(:facility_tokyo) { create(:facility, :tokyo) }
    let!(:facility_yokohama) { create(:facility, :yokohama) }
    let!(:facility_chiba) { create(:facility, :chiba) }

    context '検索パラメーターが空またはnilの場合' do
      it '全件分を返すこと' do
        result = described_class.search_vacancies(nil).result
        expect(result).to contain_exactly(facility_tokyo, facility_yokohama, facility_chiba)
      end
    end

    context '各カラムに対応したキーワードで検索する場合' do
      it '名前(name)に部分一致する施設を返すこと' do
        result = described_class.search_vacancies({ keyword: 'サウナ' }).result
        expect(result).to include(facility_tokyo)
        expect(result).not_to include(facility_yokohama, facility_chiba)
      end

      it '住所(address)に部分一致する施設を返すこと' do
        result = described_class.search_vacancies({ keyword: '東京都' }).result
        expect(result).to include(facility_tokyo)
        expect(result).not_to include(facility_yokohama, facility_chiba)
      end

      it '紹介文(introduction)に部分一致する施設を返すこと' do
        result = described_class.search_vacancies({ keyword: '露天風呂' }).result
        expect(result).to include(facility_chiba)
        expect(result).not_to include(facility_tokyo, facility_yokohama)
      end
    end

    context '一致しないキーワードで検索する場合' do
      it '空の結果を返すこと' do
        result = described_class.search_vacancies({ keyword: '存在しないキーワード' }).result
        expect(result).to be_empty
      end
    end

    context 'キーワードの空白・全角半角の場合' do
      it '全角英数字を半角英数字に正規化して検索できること' do
        facility_num = create(:facility, name: 'サンプルの湯2号店')
        result = described_class.search_vacancies({ keyword: 'サンプルの湯２' }).result
        expect(result).to include(facility_num)
      end

      it '前後の余白や連続したスペースが除外されること' do
        result = described_class.search_vacancies({ keyword: ' 街中 ' }).result
        expect(result).to include(facility_tokyo)
      end
    end

    context '複数のキーワードで検索する場合（AND検索）' do
      it 'スペース区切りの複数キーワードですべてに合致する施設のみを返すこと' do
        result = described_class.search_vacancies({ keyword: '東京 街中' }).result
        expect(result).to include(facility_tokyo)
        expect(result).not_to include(facility_yokohama, facility_chiba)
      end

      it '全角スペース区切りでも正しくAND検索ができること' do
        result = described_class.search_vacancies({ keyword: '東京　街中' }).result
        expect(result).to include(facility_tokyo)
      end
    end

    context 'ソートパラメータ(s)が指定された場合' do
      it '指定されたソート順がransackオブジェクトに引き継がれること' do
        search = described_class.search_vacancies({ keyword: '', s: 'price asc' })
        expect(search.sorts.first.name).to eq 'price'
        expect(search.sorts.first.dir).to eq 'asc'
      end
    end

    context 'kaminari(ページネーション)との連動検証' do
      it '検索結果に対してpageメソッドやperメソッドがエラーなく呼び出せること' do
        expect do
          described_class.search_vacancies({ keyword: 'サウナ' }).result.page(1).per(1)
        end.not_to raise_error
      end
    end
  end

  describe '#update_average_rating' do
    let(:facility) { create(:facility) }

    context '口コミ(reviews)が存在しない場合' do
      it 'average_ratingが0.0になること' do
        facility.update_average_rating
        expect(facility.reload.average_rating).to eq 0.0
      end
    end

    context '口コミ(reviews)が存在する場合' do
      it '各評価項目の平均が正しく計算され、小数点第1位で四捨五入されること' do
        create(:review, facility: facility, cleanliness_rating: 4, relaxation_rating: 4, bedrock_bath_rating: 4,
                        food_rating: 4, rest_space_rating: 4, service_rating: 4)
        create(:review, facility: facility, cleanliness_rating: 5, relaxation_rating: 5, bedrock_bath_rating: 5,
                        food_rating: 5, rest_space_rating: 5, service_rating: 5)

        facility.update_average_rating
        expect(facility.reload.average_rating).to eq 4.5
      end

      it '評価がNULL（未入力）の項目があっても、それを除外して正しく平均を計算すること' do
        create(:review, facility: facility, cleanliness_rating: 4, relaxation_rating: 4, bedrock_bath_rating: nil,
                        food_rating: nil, rest_space_rating: nil, service_rating: 4)

        facility.update_average_rating
        expect(facility.reload.average_rating).to eq 4.0
      end
    end
  end

  describe '#rating_badge_class' do
    let(:facility) { build(:facility) }

    it '平均評価が4.5以上の場合, bg-[#FEF3C7] text-[#B45309]を返すこと' do
      allow(facility).to receive(:average_rating).and_return(4.5)
      expect(facility.rating_badge_class).to eq 'bg-[#FEF3C7] text-[#B45309]'
    end

    it '平均評価が4.0以上の場合, bg-orange-50 text-orange-600を返すこと' do
      allow(facility).to receive(:average_rating).and_return(4.0)
      expect(facility.rating_badge_class).to eq 'bg-orange-50 text-orange-600'
    end

    it '平均評価が4.0未満の場合, bg-slate-100 text-slate-600を返すこと' do
      allow(facility).to receive(:average_rating).and_return(3.9)
      expect(facility.rating_badge_class).to eq 'bg-slate-100 text-slate-600'
    end
  end
end
