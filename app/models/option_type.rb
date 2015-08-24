
# name:string presentation:string position:integer

class OptionType < ActiveRecord::Base
  has_many :option_values, dependent: :destroy, inverse_of: :option_type
  has_many :product_option_types, dependent: :destroy, inverse_of: :option_type
  has_many :products, through: :product_option_types

  validates :name, presence: true, uniqueness: true
  validates :presentation, presence: true

  after_touch :touch_all_products

  def touch_all_products
    products.update_all(updated_at: Time.current)
  end
end
