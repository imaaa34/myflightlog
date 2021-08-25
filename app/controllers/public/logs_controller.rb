class Public::LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = current_user.logs.page(params[:page]).per(6)
  end

  def show
    @log = Log.find(params[:id])
  end

  def search
    date_from = Time.zone.parse(params[:date_from])
    date_to = Time.zone.parse(params[:date_to])
    @logs = Log.search_for(date_from, date_to)
  end

  def sort
    selection = params[:keyword]
    if selection == 'favorites'
      favorites = Favorite.where(user_id: current_user.id).pluck(:log_id).sort
      @logs = Kaminari.paginate_array(Log.find(favorites)).page(params[:page]).per(6)  #配列にpageメソッドを使用
    else
      @logs = Log.sort(selection).page(params[:page]).per(6)
    end
  end

  def stats
    logs = current_user.logs
    @total_number = logs.count

    @flight_time = 0
    logs.each do |log|
      unless log.flight_time.nil?
        ft = log.flight_time
        mins = ft.strftime("%H").to_i * 60 + ft.strftime("%M").to_i
        @flight_time += mins    # 時間を分に直して計算
      end
    end

    hours = @flight_time / 60.to_f    # 分を時間に直す
    hour = hours.floor   #切り捨て
    min = format("%02d", ((hours - hour) * 60).round)    # 分が1桁の場合0埋めする
    @total_hours = "#{hour}時間#{min}分"

    # 空港グラフ項目
    dep = logs.pluck(:departure_airport)
    arv = logs.pluck(:arrival_airport)
    all_airports = (dep + arv).reject(&:blank?)  #未入力の値を配列から削除
    airports = all_airports.uniq  # 重複した値を削除

    # 空港グラフ値
    airport_num = airports.map{|a| all_airports.count(a)}

    # 空港グラフハッシュ
    @airport_hash = airports.zip(airport_num).to_h

    # 航空会社グラフ項目
    all_airlines = logs.pluck(:airline).reject(&:blank?)  #未入力の値を配列から削除
    airlines = all_airlines.uniq  # 重複した値を削除

    # 航空会社グラフ値
    airline_num = airlines.map{|a| all_airlines.count(a)}

    # 航空会社グラフハッシュ
    @airline_hash = airlines.zip(airline_num).to_h
  end

  def graph
    line_labels = []        #折れ線グラフ項目（1~12月）
    last_year_date = []     #去年1日の日付を月毎に取得、月が2桁になるよう0埋め
    this_year_date = []     #今年1日の日付を月毎に取得
    last_year = Time.now.prev_year.year.to_s
    this_year = Time.now.year.to_s

    for i in 1..12
      date1 = (last_year + i.to_s.rjust(2, '0') + '01').to_time.strftime('%Y-%m-%d')
      date2 = (this_year + i.to_s.rjust(2, '0') + '01').to_time.strftime('%Y-%m-%d')
      line_labels << i.to_s + '月'
      last_year_date << date1
      this_year_date << date2
    end

    logs = current_user.logs
     # 去年のデータ値
    line_data1 = last_year_date.map{|a| logs.where(date: Time.zone.parse(a).all_month).count}

    # 今年のデータ値
    line_data2 = this_year_date.map{|a| logs.where(date: Time.zone.parse(a).all_month).count}

    @line_hash1 = line_labels.zip(line_data1).to_h    # 去年のデータ値と項目のハッシュ
    @line_hash2 = line_labels.zip(line_data2).to_h    # 今年のデータ値と項目のハッシュ
    @line_data = [{ name: "#{last_year}年", data: @line_hash1 }, { name: "#{this_year}年", data: @line_hash2 }]
  end

  def map
    dep = current_user.logs.pluck(:departure_airport)
    arv = current_user.logs.pluck(:arrival_airport)
    gon.airport = (dep + arv).uniq.reject(&:blank?)
  end

  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    @log.user_id = current_user.id
    if @log.save
      redirect_to logs_path, notice: 'フライトログを登録しました。'
    else
      flash.now[:alert] = '投稿できませんでした。'
      render :new
    end
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    if @log.update(log_params)
      redirect_to log_path(@log), notice: 'フライトログを編集しました。'
    else
      flash.now[:alert] = '編集できませんでした。'
      render :edit
    end
  end

  def destroy
    log = Log.find(params[:id])
    log.destroy
    redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(:date, :airline, :flight_number, :aircraft, :registration_number, :boarded_class, :seat, :flight_time, :departure_airport, :departure_gate, :departure_weather, :departure_temp, :etd, :atd, :departure_runway, :arrival_airport, :arrival_gate, :arrival_weather, :arrival_temp, :eta, :ata, :arrival_runway, :comment, :image)
  end
end
