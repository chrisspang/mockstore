
rails generate scaffold Product name:string description:text available_on:date available_until:date
rails generate scaffold Property name:string presentation:string
rails generate scaffold OptionType name:string presentation:string position:integer
rails generate scaffold OptionValue name:string presentation:string position:integer option_type:references
rails generate scaffold Variant sku:string is_master:boolean price:decimal{10,2} position:integer product:references

# Product has_many Properties
rails generate model ProductProperty value:string position:integer product:references property:references

# Product has_many OptionTypes
rails generate model ProductOptionTypes position:integer product:references option_type:references

# OptionValues has_and_belongs_to_many Variants
rails generate model OptionValuesVariants option_value:references variant:references
# id: false
# Fix index
# add_index :option_values_variants, [:option_value_id, :variant_id], :unique => true
