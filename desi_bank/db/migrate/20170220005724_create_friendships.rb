class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :status

      t.timestamps null: false
    end
  end
  
  def self.down
	drop_table :friendships
  end
end
