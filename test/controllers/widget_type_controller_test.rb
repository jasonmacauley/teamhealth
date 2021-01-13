require 'test_helper'

class WidgetTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get widget_type_index_url
    assert_response :success
  end

  test "should get show" do
    get widget_type_show_url
    assert_response :success
  end

  test "should get edit" do
    get widget_type_edit_url
    assert_response :success
  end

  test "should get new" do
    get widget_type_new_url
    assert_response :success
  end

  test "should get update" do
    get widget_type_update_url
    assert_response :success
  end

  test "should get delete" do
    get widget_type_delete_url
    assert_response :success
  end

end
