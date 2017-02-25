class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.integer :user_id
      t.integer :admin_id
      t.float :amount
      t.string :status
      t.date :date

      t.timestamps null: false
    end
  end
end
