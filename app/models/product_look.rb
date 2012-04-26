class ProductLook < ActiveRecord::Base
  belongs_to :product
  belongs_to :look
end
