# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :body, presence: true, length: { minimum: 10, maximum: 300 }
  validates :cleanliness_rating, presence: true
  validates :relaxation_rating, presence: true
  validates :service_rating, presence: true
end
