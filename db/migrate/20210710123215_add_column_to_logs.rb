class AddColumnToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :departure_latitude, :float
    add_column :logs, :departure_longitude, :float
  end
end
