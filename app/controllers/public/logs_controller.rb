class Public::LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = current_user.logs
  end

  def show
    @log = Log.find(params[:id])
    @flight_time = Time.zone.parse(params[:flight_time])
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

    @flight_time = 0
    logs = current_user.logs
    logs.each do |log|
      unless log.flight_time == nil
        ft = log.flight_time
        mins = ft.strftime("%H").to_i * 60 + ft.strftime("%M").to_i
        @flight_time += mins
      end
    end
    hours = @flight_time / 60.to_f
    hour = hours.floor
    min = ((hours - hour) * 60).floor
    @total_hours = "#{hour}時間#{min}分"

  end

  def graph
  end

  def map
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