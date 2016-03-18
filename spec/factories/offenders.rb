FactoryGirl.define do
  factory :offender do
    id_citizen { Faker::Number.number(3) }
    unit_id { 1 }
    name { Faker::Name.name }
    birth_date { Faker::Date.backward(14) }
    age { Faker::Number.number(2) }
    recurrent { ["SIM", "NAO", ""].sample }
    origin_county { Faker::Address.city }
    crime_id { Faker::Number.number(2) }
    duplicated { false }
  end
end
