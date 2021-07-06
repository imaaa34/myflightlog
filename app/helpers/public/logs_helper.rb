module Public::LogsHelper

  # 日付を読みやすくする
  def show_date(date)
    date.strftime("%Y/%m/%d")
  end

  # 時間を読みやすくする
  def show_time(time)
    time.strftime("%H:%M")
  end

end
