class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :followed_id, null: false
      t.integer :follower_id, null: false

      t.timestamps
    end
    add_index :relationships, :followed_id
    add_index :relationships, :follower_id
    add_index :relationships, [:followed_id, :follower_id], unique: true
  end
end
