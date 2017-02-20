class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|

      t.timestamps null: false
    end
  end
end
