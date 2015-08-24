
# value:string position:integer product:ref property:ref

class ProductProperty < ActiveRecord::Base
  belongs_to :product, touch: true
  belongs_to :property

  validates :property, presence: true

  validates :value, presence: true
end
