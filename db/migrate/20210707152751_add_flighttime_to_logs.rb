class AddFlighttimeToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :flight_time, :datetime
  end
end
