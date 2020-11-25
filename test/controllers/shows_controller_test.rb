require 'test_helper'

class ShowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show = shows(:one)
  end

  test "should get index" do
    get shows_url
    assert_response :success
  end

  test "should get new" do
    get new_show_url
    assert_response :success
  end

  test "should create show" do
    assert_difference('Show.count') do
      post shows_url, params: { show: { available_seats: @show.available_seats, movie_id: @show.movie_id, screen_id: @show.screen_id, seat_price: @show.seat_price, show_date: @show.show_date, time_slot_id: @show.time_slot_id } }
    end

    assert_redirected_to show_url(Show.last)
  end

  test "should show show" do
    get show_url(@show)
    assert_response :success
  end

  test "should get edit" do
    get edit_show_url(@show)
    assert_response :success
  end

  test "should update show" do
    patch show_url(@show), params: { show: { available_seats: @show.available_seats, movie_id: @show.movie_id, screen_id: @show.screen_id, seat_price: @show.seat_price, show_date: @show.show_date, time_slot_id: @show.time_slot_id } }
    assert_redirected_to show_url(@show)
  end

  test "should destroy show" do
    assert_difference('Show.count', -1) do
      delete show_url(@show)
    end

    assert_redirected_to shows_url
  end
end
