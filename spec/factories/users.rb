FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    ctigi_auth_uid { rand(0..10000) }
    password { 'password' }

    factory :admin_user do
      after(:create) do |user|
        user.roles << FactoryBot.create(:role, name: "Admin", activities: ["admin:admin"])
      end
    end
  end
end
