# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '有効性の検証' do
    it 'アバター画像がなくても、その他の項目が入力されていれば有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it '有効なアバター画像(JPEG/PNG)が添付されている場合も有効であること' do
      user = build(:user, :with_avatar)
      expect(user).to be_valid
    end
  end

  describe '必須項目のバリデーション' do
    %i[nickname email password].each do |column|
      it "#{column}が空の場合は無効であること" do
        user = build(:user, column => nil)
        user.valid?
        expect(user.errors[column]).to include('を入力してください')
      end
    end
  end

  describe 'アバターのバリデーション' do
    it 'JPEG、PNG形式でない時は無効であること' do
      user = build(:user, avatar: fixture_file_upload('spec/fixtures/files/invalid.gif', 'image/gif'))
      expect(user).not_to be_valid
      expect(user.errors[:avatar]).to include('はJPEG、PNG形式の画像を選択してください。')
    end
  end

  describe 'ニックネームのバリデーション' do
    it 'ニックネームが21文字以上の場合は無効であること' do
      user = build(:user, nickname: 'a' * 21)
      expect(user).not_to be_valid
    end
  end

  describe 'メールアドレスのバリデーション' do
    %w[user@example,com userexample.com user@.com].each do |invalid_address|
      it "メールアドレスが#{invalid_address}の場合は無効であること" do
        user = build(:user, email: invalid_address)
        expect(user).not_to be_valid
      end
    end

    it 'すでに登録されているメールアドレスの場合は無効であること' do
      create(:user, email: 'existing@example.com')
      user = build(:user, email: 'existing@example.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end

  describe 'パスワードのバリデーション' do
    %w[password 12345678 pa_ss123].each do |invalid_password|
      it "形式が無効なパスワード#{invalid_password}はエラーメッセージを返すこと" do
        user = build(:user, password: invalid_password, password_confirmation: invalid_password)
        user.valid?
        expect(user.errors[:password]).to include('は半角英数字をそれぞれ１文字以上含める必要があります')
      end
    end

    it 'パスワードが７文字以下の場合は無効であること' do
      user = build(:user, password: 'passwor', password_confirmation: 'passwor')
      user.valid?
      expect(user.errors[:password]).to include('は8文字以上で入力してください')
    end

    it 'パスワードと再入力パスワードが一致していない場合は無効であること' do
      user = build(:user, password_confirmation: 'different123')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end
  end

  describe 'チェックボックスのバリデーション' do
    it '利用規約に同意していない場合は無効であること' do
      user = build(:user, terms: false)
      user.valid?
      expect(user.errors[:terms]).to include('を受諾してください')
    end
  end

  describe '.guest' do
    context 'ゲストユーザーが存在しない場合' do
      it '新しくゲストユーザーが作成されること' do
        expect { described_class.guest }.to change(described_class, :count).by(1)

        guest = described_class.order(:created_at).last
        expect(guest.email).to eq 'guest@example.com'
        expect(guest.nickname).to eq 'ゲストユーザー'
      end
    end

    context 'ゲストユーザーがすでに存在する場合' do
      before { described_class.guest }

      it '新しいレコードは作成されないこと' do
        expect { described_class.guest }.not_to change(described_class, :count)
      end

      it '既存のゲストユーザーを返すこと' do
        existing_guest = described_class.guest
        expect(existing_guest.email).to eq 'guest@example.com'
      end
    end
  end

  describe '#guest?' do
    context 'emailがguest@example.comの場合' do
      it 'trueを返すこと' do
        guest_user = build(:user, :guest)
        expect(guest_user.guest?).to be true
      end
    end

    context 'emailがguest@example.com以外の場合' do
      it 'falseを返すこと' do
        general_user = build(:user)
        expect(general_user.guest?).to be false
      end
    end
  end

  describe 'ゲストユーザーの変更・削除制限' do
    let!(:guest_user) { create(:user, :guest) }

    it 'ニックネームの変更など, データの変更が阻止されること' do
      guest_user.nickname = '変更太郎'
      expect(guest_user.save).to be false
      expect(guest_user.errors[:base]).to include('ゲストユーザーはアカウント設定を更新できません。')
    end

    it 'ゲストユーザーの削除が阻止されること' do
      expect { guest_user.destroy }.not_to change(described_class, :count)
      expect(guest_user.errors[:base]).to include('ゲストユーザーはアカウント設定を更新できません。')
    end
  end
end
