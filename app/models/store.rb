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
end
