# frozen_string_literal: true

class Facility < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
