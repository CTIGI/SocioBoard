FactoryBot.define do
  factory :role do
    name { Faker::Company.name }
    activities "admin:all"
  end
end
