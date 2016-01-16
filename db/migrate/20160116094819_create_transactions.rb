class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date
      t.integer :amount
      t.integer :user_id
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
