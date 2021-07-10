class AddCoordinateToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :latitude, :float
    add_column :logs, :longitude, :float
  end
end
