class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :sku
      t.boolean :is_master
      t.decimal :price, precision: 10, scale: 2
      t.integer :position
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
