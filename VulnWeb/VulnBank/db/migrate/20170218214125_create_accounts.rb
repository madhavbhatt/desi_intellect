class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :acct_number
      t.string :status
      t.decimal :balance
      t.string :owner

      t.timestamps null: false
    end
  end
end
