require 'test_helper'

class LocationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get location_index_url
    assert_response :success
  end

  test "should get edit" do
    get location_edit_url
    assert_response :success
  end

  test "should get update" do
    get location_update_url
    assert_response :success
  end

  test "should get new" do
    get location_new_url
    assert_response :success
  end

  test "should get delete" do
    get location_delete_url
    assert_response :success
  end

end
