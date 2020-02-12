require 'test_helper'

class ItemSellTest < ActiveSupport::TestCase

  test "has all valid attributes" do
    is = ItemSell.new
    assert_not is.valid?
    [:date, :item, :sell, :price].each do | field |
      assert_includes is.errors.details[field], error: :blank
    end
    is.date = '2019-07-05'
    is.item = items(:one)
    is.sell = sells(:one)
    is.price = 7.5
    assert is.valid?
  end

  test "item is valid" do
    is = ItemSell.new
    is.valid?
    assert_includes is.errors.details[:item], error: :blank
    is.item = Item.new
    is.valid?
    assert_includes is.errors.details[:item], { error: :invalid, value: is.item }
    is.item = items(:one)
    is.valid?
    assert_empty is.errors.details[:item]
  end

  test "sell is valid" do
    is = ItemSell.new
    is.valid?
    assert_includes is.errors.details[:sell], error: :blank
    is.sell = Sell.new
    is.valid?
    assert_includes is.errors.details[:sell], { error: :invalid, value: is.sell }
    is.sell = sells(:one)
    is.valid?
    assert_empty is.errors.details[:sell]
  end

end