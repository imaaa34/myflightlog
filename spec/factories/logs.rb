FactoryBot.define do
  factory :log do
    user
    date { Faker::Time.between(from: 2.days.ago, to: Time.now) }
    flight_number { Faker::Number.number(digits: 2) }
    aircraft { Faker::Number.number(digits: 2) }
    departure_airport { Faker::String.random(length: 4) + "空港" }
    arrival_airport { Faker::String.random(length: 4) + "空港" }
    comment { Faker::Lorem.characters(number: 100) }
  end
end
