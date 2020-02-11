require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjI1MjgxOTkyOTAsImtleSI6ImQ0ZWIyOWNmYjcxYmU3ZWIxNzE5YTllMDhhZGQ1ODgzIn0.c4M5_aDT9j4CWG-nQXj4WdFgOC0fW_RIIEXs0QtefRo' }
  end

  test "should get index" do
    get products_url, headers: @headers, as: :json
    assert_response :success
  end

  test "should show product" do
    get product_url(@product.code), headers: @headers, as: :json
    assert_response :success
  end

end