class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
	  t.string :to_account
	  t.string :from_account
      t.string :requestor
      t.string :requestee
      t.float :amount
      t.string :status

      t.timestamps null: false
    end
  end
end
