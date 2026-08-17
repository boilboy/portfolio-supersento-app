class Facility < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
