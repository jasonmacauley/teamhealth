require 'test_helper'

class TeamMemberControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get team_member_index_url
    assert_response :success
  end

  test "should get show" do
    get team_member_show_url
    assert_response :success
  end

  test "should get edit" do
    get team_member_edit_url
    assert_response :success
  end

  test "should get update" do
    get team_member_update_url
    assert_response :success
  end

  test "should get delete" do
    get team_member_delete_url
    assert_response :success
  end

  test "should get create" do
    get team_member_create_url
    assert_response :success
  end

  test "should get new" do
    get team_member_new_url
    assert_response :success
  end

end
