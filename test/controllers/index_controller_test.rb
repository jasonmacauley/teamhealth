require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get index_edit_url
    assert_response :success
  end

  test "should get update" do
    get index_update_url
    assert_response :success
  end

  test "should get new" do
    get index_new_url
    assert_response :success
  end

  test "should get delete" do
    get index_delete_url
    assert_response :success
  end

end
