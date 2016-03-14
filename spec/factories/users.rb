FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    ctigi_auth_uid { rand(0..10000) }

    factory :admin_user do
      after(:create) do |user|
        user.roles << FactoryGirl.create(:role, name: "Admin", activities: ["admin:admin"])
      end
    end
  end
end
