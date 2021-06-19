class CreateChatroomUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_users do |t|
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true
      t.datetime :last_read_at

      t.timestamps
    end
    add_index :chatroom_users, [:user_id, :chatoom_id], unique: true
  end
end
