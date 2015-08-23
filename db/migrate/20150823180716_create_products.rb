class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.date :available_on
      t.date :available_until

      t.timestamps null: false
    end
  end
end
