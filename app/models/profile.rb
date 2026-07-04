class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  validates :nickname, presence: true
end
