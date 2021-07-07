class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :logs, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  # is_validカラムがtrueであるか
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  # enum_helpでステータスを日本語化
  enum status: {beginner: 0, businessman: 1, master: 2, copilot: 3, pilot: 4}


  def self.looks(word)
		@users = User.where(["name LIKE? OR email LIKE?", "%#{word}%", "%#{word}%"])
	end

end
