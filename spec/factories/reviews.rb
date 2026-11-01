# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    association :facility
    association :user

    body { '口コミ以上の体験ができました。' }
    cleanliness_rating { nil }
    relaxation_rating { nil }
    bedrock_bath_rating { nil }
    food_rating { nil }
    rest_space_rating { nil }
    service_rating { nil }
  end
end
