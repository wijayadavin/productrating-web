# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  city       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Store < ApplicationRecord
  has_many :products, :dependent => :delete_all

  validates :name, presence: true
  validates :city, presence: true


  # ==  ✔️Bonus TODO: A method to 'calculate' store average rating:
  # 
  def average_rating
    @rating_sum = 0
    @count = 0

    # Get all products by store id:
    @Products = Product.where({store_id: self[:id]})

    # Loop through the product and calculate:
    @Products.each {|product|
      @average_rating = product.average_rating
      unless @average_rating.nil?
        @rating_sum += @average_rating
        @count += 1
      end
    }
    if @count < 1
      @count = 1
    end

    # Return the average value:
    return @rating_sum / @count
  end


  # ==  ✔️Bonus TODO: A method to 'show' store average rating:
  # 
  def rating_helper
    @rating = self.average_rating()

    #  return rating if found, else return a notice:
    if @rating.is_a? (Integer)
      return @rating
    else
      return "There is no rating yet, be the first to rate this store!"
    end
  end


  # ==  ✔️Bonus TODO: A method to return store record by store id:
  # 
  def store
    @store = Store.find(self.store_id)
    return @store
  end


end
