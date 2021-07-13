class Public::LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = current_user.logs
  end

  def show
    @log = Log.find(params[:id])
  end

  def favorite
    favorites = Favorite.where(user_id: current_user.id).pluck(:log_id).sort
    @logs = Log.find(favorites)
  end

  def search
    date_from = Time.zone.parse(params[:date_from])
    date_to = Time.zone.parse(params[:date_to])
    @logs = Log.search_for(date_from, date_to)
  end

  def stats
    @total_number = current_user.logs.count

    # 時間を分に直して計算
    @flight_time = 0
    current_user.logs.each do |log|
      unless log.flight_time == nil
        ft = log.flight_time
        mins = ft.strftime("%H").to_i * 60 + ft.strftime("%M").to_i
        @flight_time += mins
      end
    end
    # 分を時間に直す
    hours = @flight_time / 60.to_f
    hour = hours.floor
    min = ((hours - hour) * 60).floor
    @total_hours = "#{hour}時間#{min}分"

    #空港グラフ項目
    dep = current_user.logs.pluck(:departure_airport)
    arv = current_user.logs.pluck(:arrival_airport)
    gon.airport = (dep + arv).uniq.reject(&:blank?)
    #重複した値・未入力の値を配列から削除する

    #空港グラフ値
    gon.airport_num = []
    gon.airport.each do |a|
      gon.airport_num << (dep + arv).reject(&:blank?).count(a)
    end

    #航空会社グラフ項目
    gon.airline = current_user.logs.pluck(:airline).uniq.reject(&:blank?)

    #航空会社グラフ値
    gon.airline_num = []
    gon.airline.each do |a|
      gon.airline_num << current_user.logs.pluck(:airline).reject(&:blank?).count(a)
    end
  end

  def graph
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
    log = Log.find(params[:id])
    if log.update(log_params)
      redirect_to log_path(log), notice: 'フライトログを編集しました。'
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