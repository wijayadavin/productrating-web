# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :decimal(, )
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord
  has_many :purchases
  
  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  
  validate :quantity_within_limit
  
  def quantity_within_limit
    return unless quantity

    if quantity < 0
      errors.add(:quantity, 'too few')
    end
  end

  def average_rating
    @ratings = Review.where(purchase_id: self[:id])
    if @ratings.empty?
      return "There is no rating yet, be the first to rate this product!"
    else
      return @ratings.sum(:rating) / @ratings.count(:rating)
    end
  end
end
