# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  images     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
FactoryBot.define do
  factory :post do
    body { Faker::Lorem.word }
    images { [File.open("#{Rails.root}/spec/fixtures/fixture.png")] }
    user

    trait :multiple_images do
      images { [File.open("#{Rails.root}/spec/fixtures/fixture.png"), File.open("#{Rails.root}/spec/fixtures/dummy.png")]}
    end
  end
end
