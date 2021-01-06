require 'test_helper'

class QuestionTypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get question_type_index_url
    assert_response :success
  end

  test "should get show" do
    get question_type_show_url
    assert_response :success
  end

  test "should get update" do
    get question_type_update_url
    assert_response :success
  end

  test "should get new" do
    get question_type_new_url
    assert_response :success
  end

  test "should get edit" do
    get question_type_edit_url
    assert_response :success
  end

  test "should get delete" do
    get question_type_delete_url
    assert_response :success
  end

end
