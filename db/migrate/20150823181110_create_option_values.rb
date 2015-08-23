class CreateOptionValues < ActiveRecord::Migration
  def change
    create_table :option_values do |t|
      t.string :name
      t.string :presentation
      t.integer :position
      t.references :option_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
