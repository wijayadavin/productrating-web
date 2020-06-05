# == Schema Information
#
# Table name: purchases
#
#  id               :bigint           not null, primary key
#  delivery_address :string
#  quantity         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :bigint
#
# Indexes
#
#  index_purchases_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Purchase < ApplicationRecord
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :delivery_address, presence: true

  validate :quantity_within_limit
  
  # TODO: Make sure quantity cannot be a negative number
  def quantity_within_limit
    return unless quantity && product

    if quantity > product.quantity
      errors.add(:quantity, :too_many)
    end
  end
end
