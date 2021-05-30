FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Interner.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
