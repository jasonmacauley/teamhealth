require 'test_helper'

class OrganizationRolesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organization_roles_index_url
    assert_response :success
  end

  test "should get update" do
    get organization_roles_update_url
    assert_response :success
  end

  test "should get show" do
    get organization_roles_show_url
    assert_response :success
  end

  test "should get delete" do
    get organization_roles_delete_url
    assert_response :success
  end

  test "should get new" do
    get organization_roles_new_url
    assert_response :success
  end

end
