class AddArrivalWeatherToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :arrival_weather, :string
  end
end
