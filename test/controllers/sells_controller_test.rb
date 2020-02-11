require 'test_helper'

class SellsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sell = sells(:three)
    @details = sell_details(:three)
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjI1MjgxOTkyOTAsImtleSI6ImQ0ZWIyOWNmYjcxYmU3ZWIxNzE5YTllMDhhZGQ1ODgzIn0.c4M5_aDT9j4CWG-nQXj4WdFgOC0fW_RIIEXs0QtefRo' }
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

end