FactoryBot.define do
  factroy :comment do
    body { Faker::Lorem.word }
    post
    body
  end
end
