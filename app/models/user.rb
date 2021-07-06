class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :logs, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # enum_helpで日本語化
  enum status: {beginner: 0, businessman: 1, master: 2, copilot: 3, pilot: 4}

end
