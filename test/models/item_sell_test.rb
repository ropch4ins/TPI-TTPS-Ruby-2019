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

end