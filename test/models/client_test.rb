require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  test "client has all attributes" do
    c = Client.new()
    assert_not c.valid?
    [:email, :denomination, :cuit_cuil, :vat_condition].each do | field |
      assert_includes c.errors.details[field], error: :blank
    end
    c = Client.new(email: 'a@mail.com', denomination: 'Octavio Rojas', cuit_cuil: '23275974231', vat_condition: vat_conditions(:one))
    assert c.valid?
  end

  test "email is valid" do
    c = Client.new(email: 'testmail.com')
    c.valid?
    assert_includes c.errors.details[:email], {error: :invalid, value: 'testmail.com'}
    c.email = 'test@mail.com'
    c.valid?
    assert_empty c.errors.details[:email]
  end

  test "vat condition is valid" do
    c = Client.new
    c.valid?
    assert_includes c.errors.details[:vat_condition], error: :blank
    c.vat_condition = VatCondition.new
    c.valid?
    assert_includes c.errors.details[:vat_condition], { error: :invalid, value: c.vat_condition }
    c.vat_condition = vat_conditions(:one)
    c.valid?
    assert_empty c.errors.details[:vat_condition]
  end

end