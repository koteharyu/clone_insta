# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
class Comment < ApplicationRecord

  include Rails.application.routes.url_helpers

  after_create_commit :create_notification

  validates :body, presence: true, length: { maximum: 1000 }

  belongs_to :user
  belongs_to :post

  has_one :notification, as: :noticeable, dependent: :destroy

  private
  def create_notification
    Notification.create(noticeable: self, user: post.user)
  end

  def partial_name
    "Commented_to_own_post"
  end

  def resource_path
    post_path(post)
  end
end
