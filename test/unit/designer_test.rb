require 'test_helper'

class DesignerTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Designer.new.valid?
  end
end
