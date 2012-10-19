class ProductsVoucher < ActiveRecord::Base
  belongs_to :product
  belongs_to :voucher
end
