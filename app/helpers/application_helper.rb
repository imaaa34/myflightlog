module ApplicationHelper

  def user_status(user)
    if user.logs.count < 20
      return '旅行初心者'
    elsif user.logs.count >= 20 && user.logs.count < 40
      return '出張多めビジネスマン'
    elsif user.logs.count >= 40 && user.logs.count < 60
      return 'マイル修行僧'
    elsif user.logs.count >= 60 && user.logs.count < 80
      return 'パイロット訓練生'
    elsif user.logs.count >= 80
      return 'パイロット'
    end
  end

end
