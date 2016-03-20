FactoryGirl.define do
  factory :unit do
    name { Faker::Company.name }
    capacity { rand(100) }
    occupied { rand(100) }
    measure_unit_type { 1 }
    min_age { 12 }
    max_age { 22 }
  end
end
