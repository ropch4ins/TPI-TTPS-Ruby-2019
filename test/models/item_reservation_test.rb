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
    assert ir.item.valid?
    ir.date = '2019-07-05'
    assert ir.valid?
  end

  test "reservation is valid" do
    ir = ItemReservation.new
    ir.valid?
    assert_includes ir.errors.details[:reservation], error: :blank
    ir.reservation = Reservation.new
    ir.valid?
    assert_includes ir.errors.details[:reservation], { error: :invalid, value: ir.reservation }
    ir.reservation = reservations(:one)
    ir.valid?
    assert_empty ir.errors.details[:reservation]
  end

  test "item is valid" do
    ir = ItemReservation.new
    ir.valid?
    assert_includes ir.errors.details[:item], error: :blank
    ir.item = Item.new
    ir.valid?
    assert_includes ir.errors.details[:item], { error: :invalid, value: ir.item }
    ir.item = items(:one)
    ir.valid?
    assert_empty ir.errors.details[:item]
  end

end