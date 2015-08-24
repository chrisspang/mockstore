
# name:string presentation:string position:integer option_type:ref

class OptionValue < ActiveRecord::Base
  belongs_to :option_type, touch: true

  has_many :option_value_variants
  has_many :variants, through: :option_value_variants

  #validates :name, presence: true, uniqueness: { scope: :option_type_id }
  validates :presentation, presence: true

  after_touch :touch_all_variants

  private

  def touch_all_variants
    variants.update_all(updated_at: Time.current)
  end
end
