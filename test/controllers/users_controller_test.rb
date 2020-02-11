require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {
        "data": {
          "type": "user",
          "attributes": {
            "username": "aNewUser",
            "password": "p4ssWord/123"     
          }
        }
      }, as: :json
    end

    assert_response 201
  end

end