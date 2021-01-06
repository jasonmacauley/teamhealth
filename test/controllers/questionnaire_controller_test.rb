require 'test_helper'

class QuestionnaireControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get questionnaire_index_url
    assert_response :success
  end

  test "should get show" do
    get questionnaire_show_url
    assert_response :success
  end

  test "should get update" do
    get questionnaire_update_url
    assert_response :success
  end

  test "should get new" do
    get questionnaire_new_url
    assert_response :success
  end

  test "should get edit" do
    get questionnaire_edit_url
    assert_response :success
  end

  test "should get delete" do
    get questionnaire_delete_url
    assert_response :success
  end

end
