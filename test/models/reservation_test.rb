require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  test "has all valid attributes" do
    r = Reservation.new
    r.valid?
    [:date, :client, :user].each do | field |
      assert_includes r.errors.details[field], error: :blank
    end
    r.user = users(:one)
    r.client = clients(:one)
    r.date = '2019-07-05'
    assert r.valid?
  end

  test "sell and sold? are correct" do
    r = Reservation.new
    r.user = users(:one)
    r.client = clients(:one)
    r.date = '2019-07-05'
    assert_not r.sold?
    r.update(sell: Sell.create_from_reservation(r))
    assert r.sold?
  end

end