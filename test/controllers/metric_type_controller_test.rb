require 'test_helper'

class MetricTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get metric_type_index_url
    assert_response :success
  end

  test "should get show" do
    get metric_type_show_url
    assert_response :success
  end

  test "should get edit" do
    get metric_type_edit_url
    assert_response :success
  end

  test "should get new" do
    get metric_type_new_url
    assert_response :success
  end

  test "should get update" do
    get metric_type_update_url
    assert_response :success
  end

  test "should get delete" do
    get metric_type_delete_url
    assert_response :success
  end

end
