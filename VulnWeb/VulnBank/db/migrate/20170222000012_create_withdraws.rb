class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.integer :user_id
      t.date :date
      t.float :amount

      t.timestamps null: false
    end
  end
end
