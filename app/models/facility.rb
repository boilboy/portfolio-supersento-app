# frozen_string_literal: true

class Facility < ApplicationRecord
  has_many :reviews, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :image, presence: true

  def average_rating
    columns = %i[cleanliness_rating relaxation_rating service_rating bedrock_bath_rating food_rating rest_space_rating]

    sum_sql = columns.map { |col| "COALESCE(#{col}, 0)" }.join(' + ')

    count_sql = columns.map { |col| "CASE WHEN #{col} IS NOT NULL THEN 1 ELSE 0 END" }.join(' + ')

    sql_expression = "(#{sum_sql}) / NULLIF((#{count_sql}), 0)"

    reviews.average(sql_expression)&.round(1) || 0.0
  end

  def rating_badge_class
    avg = average_rating
    if avg >= 4.5
      'bg-[#FEF3C7] text-[#B45309]'
    elsif avg >= 4.0
      'bg-orange-50 text-orange-600'
    else
      'bg-slate-100 text-slate-600'
    end
  end
end
