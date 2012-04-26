class ColorProduct < ActiveRecord::Base
  set_table_name :colors_products
  belongs_to :product
  belongs_to :color
  has_many :product_images
end
