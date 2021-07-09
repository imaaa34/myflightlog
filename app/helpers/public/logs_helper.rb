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
      hour.strftime("%-H時間%M分")
    end
  end

  # フライトタイムを時間から分に変換
  def hours_to_mins(hour)
    hour.strftime("%H").to_i * 60 + hour.strftime("%M").to_i
  end

  def mins_to_hours(min)
    hours = min / 60
    @hour = hours.float
    @min = hours - hours.float
    @total_hours = "{#hour}時間{#min}分"
  end
end
