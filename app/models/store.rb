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

  def average_rating
    @Products = Product.where({store_id: self[:id]})
    @ratings = 0
    @count = 0
    @Products.each {|product|
      @ratings += product.average_rating.to_i
      @count += 1
    }
    if @count < 1
      @count = 1
    end
    puts @ratings
    puts @count
    return @ratings / @count
  end
end
