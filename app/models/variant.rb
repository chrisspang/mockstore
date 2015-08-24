
# sku:string is_master:bool price:decimal position:int product:ref

class Variant < ActiveRecord::Base
  belongs_to :product, touch: true, inverse_of: :variants

  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants

  validates_uniqueness_of :sku, allow_blank: true  # , conditions: -> { where(deleted_at: nil) }

  def option_value(opt_name)
    self.option_values.detect { |o| o.option_type.name == opt_name }.try(:presentation)
  end


  def set_option_value(opt_name, opt_value)
    # no option values on master
    return if self.is_master

    option_type = OptionType.where(name: opt_name).first_or_initialize do |o|
      o.presentation = opt_name
      o.save!
    end

    current_value = self.option_values.detect { |o| o.option_type.name == opt_name }

    unless current_value.nil?
      return if current_value.name == opt_value
      self.option_values.delete(current_value)
    else
      # then we have to check to make sure that the product has the option type
      unless self.product.option_types.include? option_type
        self.product.option_types << option_type
      end
    end

    option_value = OptionValue.where(option_type_id: option_type.id, name: opt_value).first_or_initialize do |o|
      o.presentation = opt_value
      o.save!
    end

    self.option_values << option_value
    self.save
  end

end
