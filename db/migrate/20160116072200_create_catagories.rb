class CreateCatagories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :source
      t.text :description
      t.integer :user_id
      t.string :type

      t.timestamps null: false
    end
  end
end
