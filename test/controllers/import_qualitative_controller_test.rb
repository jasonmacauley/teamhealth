require 'test_helper'

class ImportQualitativeControllerTest < ActionDispatch::IntegrationTest
  test "should get import" do
    get import_qualitative_import_url
    assert_response :success
  end

  test "should get index" do
    get import_qualitative_index_url
    assert_response :success
  end

end
