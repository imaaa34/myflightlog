class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :logs, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true

  # is_validカラムがtrueであるか
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  # ユーザ検索機能
  def self.looks(word)
		@users = User.where(["name LIKE? OR email LIKE?", "%#{word}%", "%#{word}%"])
	end

  # ゲストログイン機能
	def self.guest
	  find_or_create_by!(email: 'guest@example.com') do |user|
	    user.password = SecureRandom.urlsafe_base64
	    user.name = 'ゲスト'
	  end
	end

end
