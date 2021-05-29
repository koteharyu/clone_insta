# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_followed_id_and_follower_id  (followed_id,follower_id) UNIQUE
#  index_relationships_on_follower_id                  (follower_id)
#
class Relationship < ApplicationRecord
  include Noticeable
  belongs_to :followed, class_name: 'User'
  belongs_to :follower, class_name: 'User'



  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def partial_name
    'followed_me'
  end

  def resource_path
    user_path(followed)
  end

  def notification_user
    followed
  end


end
