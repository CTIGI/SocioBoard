FactoryBot.define do
  factory :measure do
    start_date_measure { Faker::Date.backward(14) }
    end_date_measure { Faker::Date.forward(14) + 1.day }
    measure_type { Faker::Lorem.word }
    measure_deadline  { Faker::Number.number(3) }
    measure_situation  { Faker::Lorem.word }
    ammount_end_days { "#{Faker::Number.number(3)} dias"}
    offender { build(:offender) }
    current_period { 1 }
    current_period_date { Date.today }
  end
end
