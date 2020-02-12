require 'test_helper'

class SellsControllerTest < ActionDispatch::IntegrationTest

  include AuthorizationHelper

  setup do
    jwt = get_jwt
    @sell = sells(:three)
    @details = sell_details(:three)
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => "Bearer #{jwt}" }
  end

  test "should get index" do
    get sells_url, headers: @headers, as: :json
    assert_response :success
  end

  test "should create sell" do
    assert_difference('Sell.count') do
      post sells_url, headers: @headers, params: { 
        "data": {
          "type": "reservation",
          "attributes": {
            "date": @sell.date,
            "client_id": @sell.client_id,
            "user_id": @sell.user_id,
            "sell_details": [
              {
                "product_id": @details.product_id,
                "quantity": 1
              }
            ]
          }
        }
      }, as: :json
    end

    assert_response 201
  end

  test "should show sell" do
    get sell_url(@sell), headers: @headers, as: :json
    assert_response :success
  end

end