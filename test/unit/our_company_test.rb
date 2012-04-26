require 'test_helper'

class OurCompanyTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert OurCompany.new.valid?
  end
end
