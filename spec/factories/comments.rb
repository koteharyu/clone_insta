FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.word }
    post
    body
  end
end
