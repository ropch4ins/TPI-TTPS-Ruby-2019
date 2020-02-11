require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  
  test "product is valid" do
    i = Item.new
    i.valid?
    assert_includes i.errors.details[:product], error: :blank
    i.product = Product.new
    i.valid?
    assert_includes i.errors.details[:product], { error: :invalid, value: i.product }
    i.product = products(:one)
    i.valid?
    assert_empty i.errors.details[:product]
  end

  test "price is correct" do
    p = products(:one)
    i = p.items.first
    assert_equal p.price, i.price
  end

end