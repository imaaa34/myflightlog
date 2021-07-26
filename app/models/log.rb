class Log < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  attachment :image

  validates :date, presence: true
  validates :flight_number, presence: true
  VALID_AIRPORT_NAME = /\A*空港\z/.freeze
  validates :departure_airport, format: { with: VALID_AIRPORT_NAME, message: '「〇〇空港」と入力してください。' }, allow_blank: true
  validates :arrival_airport, format: { with: VALID_AIRPORT_NAME, message: '「〇〇空港」と入力してください。' }, allow_blank: true
  validates :comment, length: { maximum: 200 }, allow_blank: true

  # favoritesにユーザIDが存在するか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(date: :DESC)
    when 'old'
      return all.order(date: :ASC)
    when 'post_new'
      return all.order(created_at: :DESC)
    when 'post_old'
      return all.order(created_at: :ASC)
    end
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
