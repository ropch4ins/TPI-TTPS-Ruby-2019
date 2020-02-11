require 'test_helper'

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjI1MjgxOTkyOTAsImtleSI6ImQ0ZWIyOWNmYjcxYmU3ZWIxNzE5YTllMDhhZGQ1ODgzIn0.c4M5_aDT9j4CWG-nQXj4WdFgOC0fW_RIIEXs0QtefRo' }
  end

  test "should show sells with top price" do
    get "/estadisticas/ventas", headers: @headers, as: :json
    assert_response :success
  end

  test "should show users with most sells quantity" do
    get "/estadisticas/usuarios", headers: @headers, as: :json
    assert_response :success
  end

end