class RemoveArrivalWeatherFromLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :logs, :arrival_weather, :integer
  end
end
