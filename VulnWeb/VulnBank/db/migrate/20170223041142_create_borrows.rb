class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.string :from
      t.string :to
      t.date :date
      t.integer :admin_id
      t.string :status
      t.float :amount
      t.date :date

      t.timestamps null: false
    end
  end
end
