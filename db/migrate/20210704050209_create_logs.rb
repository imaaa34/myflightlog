class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|

      t.integer    :user_id,             null: false
      t.integer    :image_id,            null: false
      t.datetime   :date,                null: false
      t.string     :airline,             null: false
      t.string     :flight_number,       null: false
      t.string     :aircraft,            null: false
      t.string     :registration_number, null: false
      t.string     :class,               null: false
      t.string     :seat,                null: false
      t.string     :departure_airport,   null: false
      t.string     :departure_gate,      null: false
      t.integer    :departure_weather,   null: false, default: 0
      t.integer    :departure_temp,      null: false
      t.datetime   :etd,                 null: false
      t.datetime   :atd,                 null: false
      t.string     :departure_runway,    null: false
      t.string     :arrival_airport,     null: false
      t.string     :arrival_gate,        null: false
      t.integer    :arrival_weather,     null: false, default: 0
      t.integer    :arrival_temp,        null: false
      t.datetime   :eta,                 null: false
      t.datetime   :ata,                 null: false
      t.string     :arrival_runway,      null: false
      t.text       :comment,             null: false

      t.timestamps
    end
  end
end
