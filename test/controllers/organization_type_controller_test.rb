require 'test_helper'

class OrganizationTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organization_type_index_url
    assert_response :success
  end

  test "should get show" do
    get organization_type_show_url
    assert_response :success
  end

  test "should get edit" do
    get organization_type_edit_url
    assert_response :success
  end

  test "should get update" do
    get organization_type_update_url
    assert_response :success
  end

  test "should get new" do
    get organization_type_new_url
    assert_response :success
  end

  test "should get delete" do
    get organization_type_delete_url
    assert_response :success
  end

end
