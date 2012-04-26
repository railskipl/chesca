require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_validate_presence_of :code

  should_belong_to :department
  should_belong_to :style

  should_have_many :product_images

  should_have_one :main_image

  should_have_and_belong_to_many :related_products
end
