class Order < ActiveRecord::Base
  belongs_to :cart
  delegate :voucher_code,:to=> :cart#,:if => cart?

end
