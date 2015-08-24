
# name:string description:string available_on:date available_until:date

class Product < ActiveRecord::Base

  has_many :product_option_types, dependent: :destroy, inverse_of: :product
  has_many :option_types, through: :product_option_types
  alias :options :product_option_types

  has_many :product_properties, dependent: :destroy, inverse_of: :product
  has_many :properties, through: :product_properties

  has_one :master,
          -> { where is_master: true },
          inverse_of: :product,
          class_name: 'Variant'

  has_many :variants,
           -> { where(is_master: false).order("#{::Variant.quoted_table_name}.position ASC") },
           inverse_of: :product,
           class_name: 'Variant'

  has_many :variants_including_master,
           -> { order("#{::Variant.quoted_table_name}.position ASC") },
           inverse_of: :product,
           class_name: 'Variant',
           dependent: :destroy

  after_initialize :ensure_master

  before_validation :validate_master

  def property(property_name)
    return nil unless prop = properties.find_by(name: property_name)
    product_properties.find_by(property: prop).try(:value)
  end

  def set_property(property_name, property_value, property_presentation = property_name)
    ActiveRecord::Base.transaction do
      # Works around spree_i18n #301
      property = if Property.exists?(name: property_name)
                   Property.where(name: property_name).first
                 else
                   Property.create(name: property_name, presentation: property_presentation)
                 end
      product_property = ProductProperty.where(product: self, property: property).first_or_initialize
      product_property.value = property_value
      product_property.save!
    end
  end

  private

  def ensure_master
    return unless new_record?
    self.master ||= build_master
  end

  # If the master cannot be saved, the Product object will get its errors
  # and will be destroyed
  def validate_master
    # We call master.default_price here to ensure price is initialized.
    # Required to avoid Variant#check_price validation failing on create.
    unless master.valid?
      master.errors.each do |att, error|
        self.errors.add(att, error)
      end
    end
  end

end
