require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  should_belong_to :cart
  should_belong_to :product
  should_belong_to :size

  should_have_one :product_image
end
