require 'rails_helper'

RSpec.describe 'ユーザー認証とアカウント管理', type: :system do
  let(:new_user) { build(:user) }
  let(:existing_user) { create(:user) }
  let(:guest_user) { create(:user, :guest) }

  describe 'サインアップ•サインイン•ログアウト機能' do
    context 'ユーザー新規登録時(アバター任意)' do
      before do
        visit new_user_registration_path
        fill_in 'ニックネーム', with: new_user.nickname
        fill_in 'メールアドレス', with: new_user.email
        fill_in 'パスワード', with: new_user.password
        fill_in 'パスワード再入力', with: new_user.password_confirmation
        check 'user_terms'
      end

      context '正常系' do
        it 'アバター画像なしで、アカウントを作成してトップページに遷移すること' do
          click_button '規約に同意して登録する'

          expect(page).to have_current_path root_path
          expect(page).to have_content 'アカウント登録が完了しました。'
        end

        it 'アバター画像ありでも、アカウントを作成してトップページに遷移すること' do
          attach_file 'user_avatar', Rails.root.join('spec/fixtures/files/sample.jpg'), make_visible: true
          click_button '規約に同意して登録する'

          expect(page).to have_current_path root_path
          expect(page).to have_content 'アカウント登録が完了しました。'
        end
      end

      context '異常系' do
        it 'すでに登録されているメールアドレスの場合、登録に失敗すること' do
          fill_in 'メールアドレス', with: existing_user.email
          click_button '規約に同意して登録する'

          expect(page).to have_current_path new_user_registration_path
          expect(page).to have_content 'Eメールはすでに存在します'
        end
      end
    end

    context '通常ログイン時' do
      before { visit new_user_session_path }

      context '正常系' do
        it '登録済みのメールアドレスとパスワードでログインができること' do
          fill_in 'メールアドレス', with: existing_user.email
          fill_in 'パスワード', with: existing_user.password
          click_button 'ログイン'

          expect(page).to have_current_path root_path
          expect(page).to have_content 'ログインしました。'
        end

        it 'アカウントを持っていない場合、リンクから新規登録画面に遷移できること' do
          within('p', text: 'アカウントをお持ちでない方はこちら') do
            click_link '新規登録'
          end

          expect(page).to have_current_path new_user_registration_path
        end
      end

      context '異常系' do
        it '誤ったメールアドレスやパスワードでログインしようとすると失敗すること' do
          fill_in 'メールアドレス', with: 'wrong@example.com'
          fill_in 'パスワード', with: 'wrongpassword'
          click_button 'ログイン'

          expect(page).to have_current_path new_user_session_path
          expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        end
      end
    end

    context 'ゲストユーザー時' do
      it 'ヘッダーのゲストログインリンクからゲストログインができること' do
        visit root_path
        click_link 'ゲストでログイン'

        expect(page).to have_current_path root_path
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end

    context 'ログインしている時' do
      before do
        sign_in existing_user
        visit root_path
      end

      it 'ログアウトリンクからログアウトできること' do
        click_link 'ログアウト'
        expect(page).to have_current_path root_path
        expect(page).to have_content 'ログアウトしました。'

        expect(page).not_to have_link 'ログアウト'
        expect(page).to have_link 'ログイン'
        expect(page).to have_link '新規登録'
      end
    end
  end

  describe 'プロフィール編集•アカウント削除機能' do
    context '通常ユーザー時' do
      before do
        sign_in existing_user
        visit edit_user_registration_path
      end

      context 'プロフィール編集' do
        before do
          attach_file 'user_avatar', Rails.root.join('spec/fixtures/files/sample.jpg'), make_visible: true
          fill_in 'ニックネーム', with: existing_user.nickname
          fill_in 'メールアドレス', with: existing_user.email
          fill_in 'パスワード', with: existing_user.password
        end

        context '正常系' do
          it '現在のパスワードを入力すれば、プロフィール情報を更新できること' do
            click_button 'プロフィール情報を更新する'

            expect(page).to have_current_path root_path
            expect(page).to have_content 'アカウント情報を変更しました。'
          end
        end

        context '異常系' do
          it '間違ったパスワードを入力すれば、プロフィール情報の更新に失敗すること' do
            fill_in 'パスワード', with: 'wrongpassword'
            click_button 'プロフィール情報を更新する'

            expect(page).to have_current_path edit_user_registration_path
            expect(page).to have_content '現在のパスワードは不正な値です'
          end
        end
      end

      context 'アカウント削除' do
        it '削除リンクからログイン中のユーザー自身を削除できること' do
          expect {
            accept_confirm do
              click_link 'アカウントの削除はこちら'
            end

            expect(page).to have_current_path root_path
            expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
          }.to change(User, :count).by(-1)
        end
      end
    end

    context 'ゲストユーザー時' do
      before do
        sign_in guest_user
        visit mypage_path
      end

      it 'プロフィール画面上にアカウント登録日時や設定リンクが表示されないこと' do
        expect(page).not_to have_content '登録'
        expect(page).not_to have_link 'アカウント設定'
      end
    end
  end
end
