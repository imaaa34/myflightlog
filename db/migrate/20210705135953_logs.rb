class Logs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|

      t.integer    :user_id,             null: false
      t.integer    :image_id
      t.datetime   :date,                null: false
      t.string     :airline
      t.string     :flight_number,       null: false
      t.string     :aircraft
      t.string     :registration_number
      t.string     :boarded_class
      t.string     :seat
      t.string     :departure_airport
      t.string     :departure_gate
      t.integer    :departure_weather,   default: 0
      t.integer    :departure_temp
      t.datetime   :etd
      t.datetime   :atd
      t.string     :departure_runway
      t.string     :arrival_airport
      t.string     :arrival_gate
      t.integer    :arrival_weather,     default: 0
      t.integer    :arrival_temp
      t.datetime   :eta
      t.datetime   :ata
      t.string     :arrival_runway
      t.text       :comment

      t.timestamps
    end
  end
end
