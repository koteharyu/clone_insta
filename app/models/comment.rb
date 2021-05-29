class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 共通化（アソシエーション、コールバックによるcreate_notifications）、ダックタイピング用
  include Noticeable

  # NULL制約と文字列長1000文字の制約を追加
  validates :body, presence: true, length: { maximum: 1000 }

  # ダックタイピングのため、overrideする
  def partial_name
    'commented_to_own_post'
  end

  # ダックタイピングのため、overrideする
  def resource_path
    post_path(post, anchor: "comment-#{id}")
  end

  # ダックタイピングのため、overrideする
  def notification_user
    post.user
  end
end
