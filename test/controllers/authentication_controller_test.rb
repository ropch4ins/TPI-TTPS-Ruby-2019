require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest

  test "should authenticate" do
    post '/sesiones', params: {
      "data": {
        "type": "authentication",
        "attributes": {
          "u": "admin",
          "p": "xlAN34/aBc"
        }
      }
    }, as: :json

    assert_response 200
  end

  test "should not authenticate" do
    post '/sesiones', params: {
      "data": {
        "type": "authentication",
        "attributes": {
          "u": "asdkfjlaksdjfksdf",
          "p": "djkaslkdfjsdf//234234Dsad"
        }
      }
    }, as: :json

    assert_response 401
  end

end