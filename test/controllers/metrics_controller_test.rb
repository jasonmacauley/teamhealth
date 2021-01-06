require 'test_helper'

class MetricsControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get metrics_add_url
    assert_response :success
  end

  test "should get update" do
    get metrics_update_url
    assert_response :success
  end

  test "should get delete" do
    get metrics_delete_url
    assert_response :success
  end

end
