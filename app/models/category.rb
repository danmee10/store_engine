class Category < ActiveRecord::Base
  has_many :product_categories
  has_many :products, through: :product_categories
  attr_accessible :name

  def to_s
    name
  end
end
