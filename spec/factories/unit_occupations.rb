FactoryGirl.define do
  factory :unit_occupation do
    unit_id 1
    day { Date.today }
    occupation { rand(0..1000) }
  end
end
