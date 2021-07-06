class Log < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy

  attachment :image

  validates :date, presence: true
  validates :flight_number, presence: true

end
