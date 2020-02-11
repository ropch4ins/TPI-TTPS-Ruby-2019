require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "name and password are present" do
    u = User.new
    assert_not u.valid?
    assert_includes u.errors.details[:username], error: :blank
    assert_includes u.errors.details[:password], error: :blank
    u.password = "p4ssw0rD/#"
    u.username = "some_user"
    assert u.valid?
  end

  test "name is unique" do
    u = User.new
    u.password = "p4ssw0rD/#"
    u.username = users(:one).username
    assert_not u.valid?
    assert_includes u.errors.details[:username], { error: :taken, value: u.username }
    u.username = "some_user2"
    assert u.valid?
  end

end