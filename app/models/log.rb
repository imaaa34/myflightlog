class Log < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :date, presence: true
  validates :flight_number, presence: true

end
