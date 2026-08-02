# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    nickname { 'テスト太郎' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    terms { true }

    trait :with_avatar do
      after(:build) do |user|
        user.avatar.attach(
          io: Rails.root.join('spec/fixtures/files/sample.jpg').open,
          filename: 'sample.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :guest do
      nickname { 'ゲストユーザー' }
      email { 'guest@example.com' }
    end
  end
end
