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
  belongs_to :store
  has_many :purchases, :dependent => :delete_all

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
    #  1. get all purchases by product id:
    @purchases = Purchase.where(product_id: self[:id])
    #  2. prepare values:
    @rating_sum = 0
    @count = 0

    #  3. get ratings from each purchase:
    @purchases.each {|purchase|
      @review = Review.where(purchase_id: purchase[:id]).take
      # if found rating, add value to rating_sum and count:
      unless @review.nil?
        @rating_sum += @review[:rating]
        @count += 1
      end
    }

    #  4. calculate average review:
    if @count > 0
      @average = @rating_sum / @count
    end
    
    #  5. return result:
    if @average.nil?
      return nil
    else
      return @average
    end
  end


  def rating_helper
    #  get product average rating:
    @rating = self.average_rating()

    #  return rating if found, else return a notice:
    if @rating.is_a? (Integer)
      return @rating
    else
      return "There is no rating yet, be the first to rate this product!"
    end
  end


  def store_name
    return Store.find(self[:store_id]).name
  end


end
