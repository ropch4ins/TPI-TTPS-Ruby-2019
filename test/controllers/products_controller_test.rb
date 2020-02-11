require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  include AuthorizationHelper

  setup do
    jwt = get_jwt
    @product = products(:one)
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => "Bearer #{jwt}" }
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
