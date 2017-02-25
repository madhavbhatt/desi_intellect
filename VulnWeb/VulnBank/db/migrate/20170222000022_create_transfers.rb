class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :from
      t.string :to
      t.float :amount
      t.date :start
      t.date :effective

      t.timestamps null: false
    end
  end
end
