# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_likes_on_post_id              (post_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
class Like < ApplicationRecord
  include Noticeable

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  def partial_name
    'liked_to_own_post'
  end

  def resource_path
    post_path(post)
  end

  def notification_user
    post.user
  end
end
