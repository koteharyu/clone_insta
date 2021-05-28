# == Schema Information
#
# Table name: notifications
#
#  id            :integer          not null, primary key
#  read          :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  noticeable_id :integer
#  user_id       :integer
#
# Indexes
#
#  index_notifications_on_noticeable_id  (noticeable_id)
#  index_notifications_on_user_id        (user_id)
#
class Notification < ApplicationRecord

  include Rails.application.routes.url_helpers

  belongs_to :noticeable, polymorhpic: true
  belongs_to :user

  scope :recent, -> (count) { order(created_at: :desc).limit(count)}
  enum read: { unread: false, read: true }

  def call_appropiate_partial
    case self.noticable_type
    when "Comment"
      'commented_to_own_post'
    when "Like"
      'liked_to_own_post'
    when "Relationship"
      'followed_me'
    end
  end

  def appropiate_path
    case self.noticeable_type
    when "Comment"
      post_path(self.noticeable.post, anchor: "comment-#{noticeable.id}")
    when "Like"
      post_path(self.noticeable.post)
    when "Relationship"
      user_path(self.noticeable.followed)
    end
  end
end
