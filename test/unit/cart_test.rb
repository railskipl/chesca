require 'test_helper'

class CartTest < ActiveSupport::TestCase
  should_have_many :cart_items

  should_belong_to :voucher

end
