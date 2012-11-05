class RelatedProductColor < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_image
end
