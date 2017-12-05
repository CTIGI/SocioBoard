FactoryBot.define do
  factory :simulation do
    name { Faker::Company.name }
    data { Faker::Lorem.sentences }
    div_text { Faker::Lorem.sentences }
    user { build(:user) }
  end
end
