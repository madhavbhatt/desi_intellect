class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.integer :user_id
      t.integer :admin_id
      t.string :status
      t.float :amount
      t.date :date

      t.timestamps null: false
    end
  end
end
