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
  after_create_commit :create_notification

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  private
  def create_notification
    Notification.create(noticeable: self, user: post.user)
  end
end
