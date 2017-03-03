class AddMasterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :master, :boolean, default: false
  end
end
