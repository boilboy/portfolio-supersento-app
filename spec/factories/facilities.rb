# frozen_string_literal: true

FactoryBot.define do
  factory :facility do
    name { 'サンプルの湯' }
    address { '東京都渋谷区' }
    price { 1000 }
    introduction { '快適で最高の温浴施設です。' }

    image do
      Rack::Test::UploadedFile.new(
        StringIO.new('dummy'),
        'image/jpeg',
        original_filename: 'sample.jpg'
      )
    end

    trait :tokyo do
      name { '東京街中サウナ' }
      address { '東京都渋谷区' }
      price { 1200 }
      introduction { 'サウナが最高の温浴施設です。' }
    end

    trait :yokohama do
      name { '横浜極楽湯' }
      address { '神奈川県横浜市中区' }
      price { 1100 }
      introduction { '施設が充実のスーパー銭湯施設です。' }
    end

    trait :chiba do
      name { '千葉海浜温泉' }
      address { '千葉県千葉市美浜区' }
      price { 1000 }
      introduction { '水平線が見える素敵な露天風呂がある温浴施設です。' }
    end
  end
end
