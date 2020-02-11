require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  test "sell and sold? are correct" do
    r = reservations(:one)
    assert_not r.sold?

	r.user = users(:one)
    r.client = clients(:one)
    r.date = '2019-07-05'
    #r.user.username = "asdasd"
    #r.user.password = "p4ssw0rD/#"
    #assert r.user.valid?
    #assert r.client.valid?
    #assert r.valid?
    #s = Sell.create_from_reservation(r)
    #r.users
    r.update(sell: Sell.create_from_reservation(r))
    assert r.sold?
    #r.items.each do | item |
    #  assert item.is_sold
    #end
  end

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

end