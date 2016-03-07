FactoryGirl.define do
  factory :offender do
    id_citizen { Faker::Number.number(3) }
    unit { Faker::Address.city }
    name { Faker::Name.name }
    birth_date { Faker::Date.backward(14) }
    age { Faker::Number.number(10) }
    recurrent { ["SIM", "NAO", ""].sample }
    origin_county { Faker::Address.city }
    crime_id { Faker::Number.number(10) }
    crimes { Faker::Name.name }
  end
end
