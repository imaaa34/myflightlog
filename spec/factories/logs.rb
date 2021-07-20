FactoryBot.define do
  factory :log do
    user
    date { Faker::Time.between(from: 2.days.ago, to: Time.now) }
    airline { Faker::String.random(length: 4) }
    flight_number { Faker::Number.number(digits: 2) }
    aircraft { Faker::Number.number(digits: 2) }
    registration_number { Faker::Number.number(digits: 2) }
    boarded_class { Faker::String.random(length: 4) }
    seat { Faker::Number.number(digits: 2) }
    departure_airport { Faker::String.random(length: 4) + "空港" }
    departure_gate { Faker::Number.number(digits: 2) }
    departure_temp { Faker::Number.number(digits: 2) }
    etd { Faker::Time.between(from: 2.days.ago, to: Time.now) }
    atd { Faker::Time.between(from: 2.days.ago, to: Time.now) }
    departure_runway { Faker::Number.number(digits: 2) }
    arrival_airport { Faker::String.random(length: 4) + "空港" }
    arrival_gate { Faker::Number.number(digits: 2) }
    arrival_temp { Faker::Number.number(digits: 2) }
    eta { Faker::Time.between(from: 2.days.ago, to: Time.now) }
    ata { Faker::Time.between(from: 2.days.ago, to: Time.now) }
    arrival_runway { Faker::Number.number(digits: 2) }
    comment { Faker::Lorem.characters(number: 100) }
    departure_weather { Faker::String.random(length: 2) }
    arrival_weather { Faker::String.random(length: 2) }
    flight_time { Faker::Time.between(from: 2.days.ago, to: Time.now) }
  end
end
