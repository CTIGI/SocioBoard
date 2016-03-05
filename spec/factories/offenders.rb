FactoryGirl.define do
  factory :offender do
    id_citizen { Faker::Number.number(3) }
    unit { Faker::Address.city }
    name { Faker::Name.name }
    birth_date { Faker::Date.backward(14) }
    age { Faker::Number.number(10) }
    recurrent { ["SIM", "NAO", ""].sample }
    origin_county { Faker::Address.city }
    article { Faker::Name.title }
    measure_type { Faker::Lorem.word }
    measure_deadline { Faker::Number.number(3) }
    start_date_measure { Faker::Date.backward(14) }
    end_date_measure { Faker::Date.forward(14) }
    measure_situation { Faker::Lorem.word }
    ammount_end_days { "#{Faker::Number.number(3)} dias"}
  end
end
