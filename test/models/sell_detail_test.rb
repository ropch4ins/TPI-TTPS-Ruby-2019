require 'test_helper'

class SellDetailTest < ActiveSupport::TestCase

  test "has all valid attributes" do
    sd = SellDetail.new
    assert_not sd.valid?
    [:quantity, :product, :sell].each do | field |
      assert_includes sd.errors.details[field], error: :blank
    end
    sd.quantity = 4
    sd.product = products(:one)
    sd.sell = sells(:one)
    assert sd.valid?
  end

end
