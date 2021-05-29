class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 共通化（アソシエーション、コールバックによるcreate_notifications）、ダックタイピング用
  include Noticeable

  validates :user_id, uniqueness: { scope: :post_id }

  # ダックタイピングのため、overrideする
  def partial_name
    'liked_to_own_post'
  end

  # ダックタイピングのため、overrideする
  def resource_path
    post_path(post)
  end

  # ダックタイピングのため、overrideする
  def notification_user
    post.user
  end
end
