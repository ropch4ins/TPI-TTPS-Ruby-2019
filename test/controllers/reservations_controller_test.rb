require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest

  include AuthorizationHelper

  setup do
    jwt = get_jwt
    @reservation = reservations(:three)
    @details = reservation_details(:three)
    @headers = { 'accept' => 'application/vnd.api+json', 'content-type' => 'application/vnd.api+json', 'authorization' => "Bearer #{jwt}" }
  end

  test "should get index" do
    get reservations_url, headers: @headers, as: :json
    assert_response :success
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post reservations_url, headers: @headers, params: { 
        "data": {
          "type": "reservation",
          "attributes": {
            "date": @reservation.date,
            "client_id": @reservation.client_id,
            "user_id": @reservation.user_id,
            "reservation_details": [
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

  test "should show reservation" do
    get reservation_url(@reservation), headers: @headers, as: :json
    assert_response :success
  end

  test "should convert reservation to sell" do
    put "/reservas/#{@reservation.id}/vender", headers: @headers, as: :json
    assert_response 200
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete reservation_url(@reservation), headers: @headers, as: :json
    end

    assert_response 204
  end

end