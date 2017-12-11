FactoryBot.define do
  factory :crime do
    name { Faker::Name.name }
    offender_id 1
  end
end
