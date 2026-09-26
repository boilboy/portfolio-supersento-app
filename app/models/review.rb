# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  after_commit :update_facility_average_rating, on: %i[create destroy]

  validates :body, presence: true, length: { minimum: 10, maximum: 300 }
  validates :cleanliness_rating, presence: true
  validates :relaxation_rating, presence: true
  validates :service_rating, presence: true

  private

  def update_facility_average_rating
    facility.update_average_rating
  end
end
