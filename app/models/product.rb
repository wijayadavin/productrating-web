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
  # belongs_to :place
  # has_one :market
  # has_one_attached :image

  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  # validates :place_id, presence: true
  # validates :name, presence: true
  # validates :quantity, presence: true
  # validates :year_created, presence: true
end
