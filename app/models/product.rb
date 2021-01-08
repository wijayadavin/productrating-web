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
  has_many :reviews, through: :purchases, :dependent => :delete_all

  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  
  validate :quantity_within_limit


  # == A function to validate the quantity value:
  # 
  def quantity_within_limit
    return unless quantity

    if quantity < 0
      errors.add(:quantity, 'too few')
    end
  end


  # ==  ✔️Bonus TODO: A method to 'calculate' average product rating
  #  
  def average_rating
    #  get all rating average by product id:
    @average = Product.includes([
        :purchases => [:reviews]
      ]).where({id: self[:id]}).average(:rating).to_i

    if @average.nil?
      return nil
    else
      return @average
    end
  end


  # ==  ✔️Bonus TODO: A method to 'show' product average rating:
  # 
  def rating_helper
    @rating = self.average_rating()

    #  return rating if found, else return a notice:
    if @rating.is_a? (Integer)
      return @rating
    else
      return "There is no rating yet, be the first to rate this product!"
    end
  end


  # ==  ✔️Bonus TODO: A function to get store name:
  def store_name
    return Store.find(self[:store_id]).name
  end


end
