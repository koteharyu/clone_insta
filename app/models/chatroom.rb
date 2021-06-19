# == Schema Information
#
# Table name: chatrooms
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :messages, dependent: :destroy

  def self.chatroom_for_users(users)
    user_ids = users.map(&:id).sort
    name = user_ids.join(':').to_s

    unless chatroom = find_by(name: name)
      chatroom = new(name: name)
      chatroom.users = users
      chatroom.save
    end
  end
end
