require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  test "code is unique" do
    assert Product.new(code: 'ABC123456', description:'Descripcion', detail:'Detalles extensos', price: 20.5).save
    assert_not Product.new(code: 'ABC123456', description:'Descripcion', detail:'Detalles extensos', price: 20.5).valid?, "product code repeats"
  end

  test "code is valid" do
    assert Product.new(code: 'ABC123456', description:'Descripcion', detail:'Detalles extensos', price: 320.23).valid?
    assert_not Product.new(code: 'ABC1234567', description:'Descripcion', detail:'Detalles extensos', price: 320.23).valid?
    assert_not Product.new(code: 'AB123456', description:'Descripcion', detail:'Detalles extensos', price: 320.23).valid?
  end

  test "description in less than 200 chars" do
    description = (0...210).map { (65 + rand(26)).chr }.join
    assert_not Product.new(code: 'QWE234567', description: description, detail:'Detalles extensos', price: 10.2).valid?, "description is too long"
    description = (0...200).map { (65 + rand(26)).chr }.join
    assert Product.new(code: 'QWE234567', description: description, detail:'Detalles extensos', price: 10.2).valid?
  end

  test "product has all attributes" do
    assert_not Product.new.valid?
    assert_not Product.new(code: 'ABC123456').valid?
    assert_not Product.new(code: 'ABC123456', description:'Descripcion').valid?
    assert_not Product.new(code: 'ABC123456', description:'Descripcion', detail: 'Detalles extensos').valid?
    assert Product.new(code: 'ABC123456', description:'Descripcion', detail: 'Detalles extensos', price: 4320.34).valid?
  end

  test "stock is correct" do
    assert_equal 5, products(:three).stock
    assert_equal 6, products(:four).stock
    assert_equal 0, products(:five).stock
  end

  test "in_stock is correct" do
    assert     Product.in_stock.include? products(:three)
    assert     Product.in_stock.include? products(:four)
    assert_not Product.in_stock.include? products(:five)
  end

  test "scarce is correct" do
    assert_includes     Product.scarce, products(:three)
    assert_not_includes Product.scarce, products(:four)
    assert_not_includes Product.scarce, products(:five)
  end

end