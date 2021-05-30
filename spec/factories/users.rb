FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Interner.email }
    password { 'password' }
    password_confirmation { 'password' }
    notification_on_comment { false }
    notification_on_like { false }
    notification_on_follow { false }
  end
end
