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
