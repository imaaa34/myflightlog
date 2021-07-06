class RemoveDepartureWeatherFromLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :logs, :departure_weather, :integer
  end
end
