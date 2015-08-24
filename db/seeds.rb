# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.destroy_all
Property.destroy_all
OptionType.destroy_all
OptionValue.destroy_all
OptionValueVariant.destroy_all
Variant.destroy_all
ProductOptionType.destroy_all

properties = Property.create(
  [
    {
      name: 'type',
      presentation: 'Product Type'
    },
    {
      name: 'recurrable',
      presentation: 'Recurrable Item'
    }
  ]
)

hw = Product.create(
  {
    name: 'v60',
    description: 'Hario V60',
    available_on: '1/1/2015',
    available_until: '1/1/3000',
    master: Variant.new(
      {
        sku: 'HW-001',
        is_master: true,
        price: 49.99,
        position: 1,
      },
    ),
  }
)
hw.set_property('type', 'hardware', 'Hardware')
hw.set_property('recurrable', 'false', 'false')

ot = OptionType.create(
  {
    name: 'preparation',
    presentation: 'Coffee Preparation',
    option_values: OptionValue.create(
      [
        {
          name: 'aeropress',
          presentation: 'Aeropress'
        },
        {
          name: 'espresso',
          presentation: 'Espresso'
        },
        {
          name: 'v60',
          presentation: 'V60'
        }
      ])
  }
)

p = Product.create(
  {
    name: 'coffee lovelee',
    description: 'Coffee Lovelee',
    available_on: '1/1/2015',
    available_until: '1/1/2016',
    master: Variant.new(
      {
        sku: 'CO-001',
        is_master: true,
        price: 6.95,
        position: 1,
      },
    ),
  }
)
p.set_property('type', 'coffee', 'Coffee')
p.set_property('recurrable', 'true', 'true')

p.option_types << ot

# p.master.set_option_value('preparation', 'Aeropress')

puts ""
puts "We have #{Product.count} Products"
puts "We have #{Property.count} Properties"
puts "We have #{OptionType.count} OptionTypes"
puts "We have #{OptionValue.count} OptionValues"
puts "We have #{Variant.count} Variants"
