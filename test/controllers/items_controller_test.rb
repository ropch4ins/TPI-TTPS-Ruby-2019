require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjI1MjgxOTkyOTAsImtleSI6ImQ0ZWIyOWNmYjcxYmU3ZWIxNzE5YTllMDhhZGQ1ODgzIn0.c4M5_aDT9j4CWG-nQXj4WdFgOC0fW_RIIEXs0QtefRo' }
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
    end

    assert_response 204
  end

  test "should show item" do
    get "/productos/#{@item.product.code}/items", headers: @headers, as: :json
    assert_response :success
  end

end