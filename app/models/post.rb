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
  serialize :images, JSON # imagesという属性をJSON形式に保存させるため

  validates :body, presence: true, length: { maximum: 1000 }
  validates :images, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :notification, as: :noticeable, dependent: :destroy

  scope :body_contain, ->(word) { Post.where('body LIKE ?', "%#{word}%") }
end
