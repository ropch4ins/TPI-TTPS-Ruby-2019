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

  test "product is valid" do
    sd = SellDetail.new
    sd.valid?
    assert_includes sd.errors.details[:product], error: :blank
    sd.product = Product.new
    sd.valid?
    assert_includes sd.errors.details[:product], { error: :invalid, value: sd.product }
    sd.product = products(:one)
    sd.valid?
    assert_empty sd.errors.details[:product]
  end

  test "sell is valid" do
    sd = SellDetail.new
    sd.valid?
    assert_includes sd.errors.details[:sell], error: :blank
    sd.sell = Sell.new
    sd.valid?
    assert_includes sd.errors.details[:sell], { error: :invalid, value: sd.sell }
    sd.sell = sells(:one)
    sd.valid?
    assert_empty sd.errors.details[:sell]
  end

end
