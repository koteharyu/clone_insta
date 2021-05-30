FactoryBot.define do
  factory :post do
    body { Faker::Lorem.word }
    images { [File.open("#{Rails.root}/spec/fixtures/fixture.png")] }
    user
  end
end
