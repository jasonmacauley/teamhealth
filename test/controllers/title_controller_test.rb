require 'test_helper'

class TitleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get title_index_url
    assert_response :success
  end

  test "should get show" do
    get title_show_url
    assert_response :success
  end

  test "should get edit" do
    get title_edit_url
    assert_response :success
  end

  test "should get new" do
    get title_new_url
    assert_response :success
  end

  test "should get update" do
    get title_update_url
    assert_response :success
  end

  test "should get delete" do
    get title_delete_url
    assert_response :success
  end

end
