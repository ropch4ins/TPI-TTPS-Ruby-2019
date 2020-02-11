require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "password is present, name is unique" do
    u = User.new
    assert_not u.valid?
    assert_includes u.errors.details[:username], error: :blank
    assert_includes u.errors.details[:password], error: :blank
    u.username = users(:one).username
    assert_not u.valid?
    assert_includes u.errors.details[:username], { error: :taken, value: u.username }
    u.password= "p4ssw0rD/#"
    u.username= "user1"
    assert u.valid?
  end

end