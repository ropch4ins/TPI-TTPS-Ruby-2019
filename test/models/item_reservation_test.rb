require 'test_helper'

class ItemReservationTest < ActiveSupport::TestCase

  test "has all valid attributes" do
    ir = ItemReservation.new
    assert_not ir.valid?
    [:reservation, :item, :date].each do | field |
      assert_includes ir.errors.details[field], error: :blank
    end
    ir.reservation = reservations(:one)
    ir.item = items(:one)
    ir.date = '2019-07-05'
    assert ir.valid?
  end

end