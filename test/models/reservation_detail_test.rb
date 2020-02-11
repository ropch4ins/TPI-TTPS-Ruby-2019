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

end
