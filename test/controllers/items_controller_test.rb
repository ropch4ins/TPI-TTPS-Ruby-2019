require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest

  include AuthorizationHelper

  setup do
    jwt = get_jwt
    @item = items(:one)
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => "Bearer #{jwt}" }
  end


  test "should create item" do
    assert_difference('Item.count') do
      post "/productos/#{@item.product.code}/items", headers: @headers, params: {
        "data": {
          "attributes": {
            "quantity": 1
          }
        }
      }, as: :json

      puts response.body
    end

    assert_response 204
  end

  test "should show item" do
    get "/productos/#{@item.product.code}/items", headers: @headers, as: :json
    assert_response :success
  end

end