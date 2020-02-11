require 'test_helper'

class StatisticsControllerTest < ActionDispatch::IntegrationTest

  include AuthorizationHelper

  setup do
    jwt = get_jwt
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => "Bearer #{jwt}" }
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