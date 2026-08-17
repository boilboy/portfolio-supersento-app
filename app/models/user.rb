# frozen_string_literal: true

class User < ApplicationRecord
  before_update :ensure_normal_user
  before_destroy :ensure_normal_user

  has_many :reviews, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar, dependent: :destroy

  validates :avatar, content_type: { in: %w[image/jpeg image/png], message: :invalid_image_type }
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
    message: :invalid_password_format
  }, allow_blank: true
  validates :terms, acceptance: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = 'Password123'
      user.nickname = 'ゲストユーザー'
    end
  end

  def guest?
    email == 'guest@example.com'
  end

  private

  def ensure_normal_user
    return unless guest?

    errors.add(:base, :cannot_update_guest_user)
    throw :abort
  end
end
