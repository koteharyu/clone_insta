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
class Post < ApplicationRecord
  mount_uploaders :images, PostImagesUploader

  validates :body, presence: true, length: { maximum: 1000 }
  validates :images, presecne: true
  
  belongs_to :user
end
