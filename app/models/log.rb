class Log < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy

  attachment :image

  validates :date, presence: true
  validates :flight_number, presence: true

  # favoritesにユーザIDが存在するか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 日付範囲で検索
  # scope :search, -> (search_params) do
  #   return if search_params.blank?

  #   date_from(search_params[:date_from])
  #   date_to(search_params[:date_to])
  # end

  # scope :date_from, -> (from) { where('? <= date', from) if from.present? }
  # scope :date_to, -> (to) { where('date <= ?', to) if to.present? }

  scope :date_between, -> from, to {
    if from.present? && to.present?
      where(date: from..to)
    elsif from.present?
      where('date >= ?', from)
    elsif to.present?
      where('date <= ?', to)
    end
  }
end
