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
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # 共通化（アソシエーション、コールバックによるcreate_notifications）、ダックタイピング用
  include Noticeable

  # NULL制約
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  # ユニーク制約
  validates :follower_id, uniqueness: { scope: :followed_id }

  # ダックタイピングのため、overrideする
  def partial_name
    'followed_me'
  end

  # ダックタイピングのため、overrideする
  def resource_path
    user_path(follower)
  end

  # ダックタイピングのため、overrideする
  def notification_user
    followed
  end
end
