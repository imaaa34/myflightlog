module Public::LogsHelper

  # 日付を読みやすくする
  def show_date(date)
    date.strftime("%Y/%m/%d")
  end

  # 時間を読みやすくする
  def show_time(time)
    unless time.nil?
      time.strftime("%H:%M")
    end
  end

  # フライトタイムを読みやすくする
  def show_hour(hour)
    unless hour.nil?
      hour.strftime("%H時間%M分")
    end
  end

end
