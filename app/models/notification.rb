# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  noticeable_type :string
#  read            :boolean          default("unread"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  noticeable_id   :integer
#  user_id         :integer
#
# Indexes
#
#  index_notifications_on_noticeable_type_and_noticeable_id  (noticeable_type,noticeable_id)
#  index_notifications_on_user_id                            (user_id)
#
class Notification < ApplicationRecord
  # relationships, likes, commentsテーブルにポリモーフィックに関連付ける
  belongs_to :noticeable, polymorphic: true
  # ユーザーに紐づく通知一覧を取得するため、一対多の関連付けを実装
  belongs_to :user

  # scopeを定義 → 指定した件数の通知を最新のものから取得する
  scope :recent, ->(count) { order(created_at: :desc).limit(count) }

  # enumを使って、unreadとreadメソッドで未読通知と既読通知を取得できるようにする
  enum read: { unread: false, read: true }

  # 適切なパーシャルを取得するメソッド（ダックタイピングを活用）
  def call_appropiate_partial
    noticeable.partial_name
  end

  # 適切なパスを取得するメソッド（ダックタイピングを活用）
  def appropiate_path
    noticeable.resource_path
  end
end
