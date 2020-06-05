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
end
