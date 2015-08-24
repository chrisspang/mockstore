
# option_value:ref variant:ref (note: no id)

class OptionValueVariant < ActiveRecord::Base
  belongs_to :option_value
  belongs_to :variant

  # acts_as_list scope: :product
end
