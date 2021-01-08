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
  has_many :purchases, through: :products, :dependent => :delete_all
  has_many :reviews, through: :purchases, :dependent => :delete_all

  validates :name, presence: true
  validates :city, presence: true


  # ==  ✔️Bonus TODO: A method to 'calculate' store average rating:
  # 
  def average_rating
    #  get all rating average by store id:
    @average = Store.includes([
        :products => [:purchases => [:reviews]]
      ]).where({id: self[:id]}).average(:rating).to_i

    if @average.nil?
      return nil
    else
      return @average
    end
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
