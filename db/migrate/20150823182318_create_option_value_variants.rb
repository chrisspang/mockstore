class CreateOptionValueVariants < ActiveRecord::Migration
  def change
    create_table :option_value_variants, id: false do |t|
      t.references :option_value, index: false, foreign_key: true
      t.references :variant, index: false, foreign_key: true

      t.timestamps null: false
    end

    add_index :option_value_variants, [:option_value_id, :variant_id], :unique => true
  end
end
