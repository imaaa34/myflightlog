module ApplicationHelper

  def user_status(user)
    if user.logs.count < 10
      return '旅行初心者'
    elsif user.logs.count >= 10 && user.logs.count < 30
      return '出張多めビジネスマン'
    elsif user.logs.count >= 30 && user.logs.count < 50
      return 'マイル修行僧'
    elsif user.logs.count >= 50 && user.logs.count < 80
      return 'パイロット訓練生'
    elsif user.logs.count >= 80
      return 'パイロット'
    end
  end

end
