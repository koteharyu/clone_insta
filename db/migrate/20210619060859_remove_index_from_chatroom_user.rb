class RemoveIndexFromChatroomUser < ActiveRecord::Migration[5.2]
  def change
    remove_index :chatroom_users, name: "index_chatroom_users_on_user_id_and_chatoom_id"
  end
end
