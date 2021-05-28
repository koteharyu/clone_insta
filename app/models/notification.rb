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
end
