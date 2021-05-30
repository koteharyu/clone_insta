# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  avatar                  :string
#  crypted_password        :string
#  email                   :string           not null
#  name                    :string           not null
#  notification_on_comment :boolean          default(TRUE)
#  notification_on_follow  :boolean          default(TRUE)
#  notification_on_like    :boolean          default(TRUE)
#  salt                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
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
