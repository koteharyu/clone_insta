# == Schema Information
#
# Table name: chatroom_users
#
#  id           :integer          not null, primary key
#  last_read_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chatroom_id  :integer
#  user_id      :integer
#
# Indexes
#
#  index_chatroom_users_on_chatroom_id              (chatroom_id)
#  index_chatroom_users_on_user_id                  (user_id)
#  index_chatroom_users_on_user_id_and_chatroom_id  (user_id,chatroom_id) UNIQUE
#
class ChatroomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
end
