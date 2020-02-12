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

  test "user is valid" do
    s = Sell.new
    s.valid?
    assert_includes s.errors.details[:user], error: :blank
    s.user = User.new
    s.valid?
    assert_includes s.errors.details[:user], { error: :invalid, value: s.user }
    s.user = users(:one)
    s.valid?
    assert_empty s.errors.details[:user]
  end

  test "reservation is valid" do
    s = Sell.new
    s.reservation = Reservation.new
    s.valid?
    assert_includes s.errors.details[:reservation], { error: :invalid, value: s.reservation }
    s.reservation = reservations(:one)
    s.valid?
    assert_empty s.errors.details[:reservation]
  end

  test "total_price is correct" do
  	s = sells(:two)
  	assert_not_equal s.total_price, 1.5
  	assert_equal s.total_price, 5 * 1.5
  end

end