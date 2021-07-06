class AddDepartureWeatherToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :departure_weather, :string
  end
end
