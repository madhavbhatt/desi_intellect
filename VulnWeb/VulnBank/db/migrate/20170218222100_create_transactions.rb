class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :from
      t.string :to
      t.string :status
      t.date :start
      t.date :effective

      t.timestamps null: false
    end
  end
end
