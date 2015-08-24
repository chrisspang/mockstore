
# name:string presentation:string

class Property < ActiveRecord::Base

  has_many :product_properties, dependent: :delete_all, inverse_of: :property
  has_many :products, through: :product_properties

  validates :name, :presentation, presence: true
end
