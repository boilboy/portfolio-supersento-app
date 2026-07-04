class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar, dependent: :destroy

  validates :avatar, content_type: { in: %w[image/jpeg image/png], message: 'はJPEG、PNG形式の画像を選択してください。' }
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
    message: 'は半角英数字をそれぞれ１文字以上含める必要があります'
  }, allow_blank: true
  validates :terms, acceptance: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲストユーザー'
    end
  end

  def guest?
    email == 'guest@example.com'
  end
end
