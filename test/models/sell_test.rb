require 'test_helper'

class SellTest < ActiveSupport::TestCase

  test "has all valid attributes" do
    s = Sell.new
    assert_not s.valid?
    [:user, :client, :date].each do | field |
      assert_includes s.errors.details[field], error: :blank
    end
    s.user = users(:one)
    s.client = clients(:one)
    s.date = '2019-07-05'
    assert s.valid?
  end


  test "total_price is correct" do
  	s = sells(:two)
  	assert_not_equal s.total_price, 1.5
  	assert_equal s.total_price, 5 * 1.5
  end

end