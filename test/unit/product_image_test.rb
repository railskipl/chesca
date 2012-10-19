require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  should_have_attached_file :image
end
