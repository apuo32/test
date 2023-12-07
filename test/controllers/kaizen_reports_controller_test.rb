require "test_helper"

class KaizenReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get kaizen_reports_new_url
    assert_response :success
  end

  test "should get edit" do
    get kaizen_reports_edit_url
    assert_response :success
  end

  test "should get show" do
    get kaizen_reports_show_url
    assert_response :success
  end
end
