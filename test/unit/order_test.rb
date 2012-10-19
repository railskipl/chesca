require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should_belong_to :cart
end
