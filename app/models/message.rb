# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  body        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_messages_on_chatroom_id  (chatroom_id)
#  index_messages_on_user_id      (user_id)
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  validates :body, presence: true, length: { maximum: 1000 }
end
