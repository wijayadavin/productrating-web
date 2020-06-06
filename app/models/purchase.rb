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

  # TODO: Implement this logic
  # - Return true if a review for this purchase exists in the database 
  # - Return false otherwise
  def review_exist?
    false
  end
end
