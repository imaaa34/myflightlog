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

  # 日付範囲が片方のみでも検索可能
  def self.search_for(from, to)
    if from.present? && to.present?
      @logs = Log.where(date: from..to)
    elsif from.present?
      @logs = Log.where('date >= ?', from)
    elsif to.present?
      @logs = Log.where('date <= ?', to)
    else
      @logs = Log.all
    end
  end
end
