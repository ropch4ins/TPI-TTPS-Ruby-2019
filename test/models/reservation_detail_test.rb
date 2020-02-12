require 'test_helper'

class ReservationDetailTest < ActiveSupport::TestCase
  
  test "has all valid attributes" do
    rd = ReservationDetail.new
    assert_not rd.valid?
    [:quantity, :product, :reservation].each do | field |
      assert_includes rd.errors.details[field], error: :blank
    end
    rd.quantity = 4
    rd.product = products(:one)
    rd.reservation = reservations(:one)
    assert rd.valid?
  end

  test "product is valid" do
    rd = ReservationDetail.new
    rd.valid?
    assert_includes rd.errors.details[:product], error: :blank
    rd.product = Product.new
    rd.valid?
    assert_includes rd.errors.details[:product], { error: :invalid, value: rd.product }
    rd.product = products(:one)
    rd.valid?
    assert_empty rd.errors.details[:product]
  end

  test "reservation is valid" do
    rd = ReservationDetail.new
    rd.valid?
    assert_includes rd.errors.details[:reservation], error: :blank
    rd.reservation = Reservation.new
    rd.valid?
    assert_includes rd.errors.details[:reservation], { error: :invalid, value: rd.reservation }
    rd.reservation = reservations(:one)
    rd.valid?
    assert_empty rd.errors.details[:reservation]
  end

end