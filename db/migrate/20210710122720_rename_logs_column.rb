class RenameLogsColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :logs, :latitude, :arrival_latitude
    rename_column :logs, :longitude, :arrival_longitude
  end
end
