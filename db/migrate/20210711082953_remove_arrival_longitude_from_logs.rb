class RemoveArrivalLongitudeFromLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :logs, :arrival_longitude, :float
    remove_column :logs, :arrival_latitude, :float
    remove_column :logs, :departure_longitude, :float
    remove_column :logs, :departure_latitude, :float
  end
end
