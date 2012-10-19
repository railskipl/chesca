class Size < ActiveRecord::Base
  has_many :product_sizes
  has_many :product, :through => :product_sizes
end
