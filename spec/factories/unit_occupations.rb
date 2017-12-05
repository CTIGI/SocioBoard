FactoryBot.define do
  factory :unit_occupation do
    unit {  build(:unit) }
    day { Date.today }
    occupation { rand(0..1000) }
  end
end
