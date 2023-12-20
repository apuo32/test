require "test_helper"

class SubmittedKaizenReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get submitted_kaizen_reports_edit_url
    assert_response :success
  end

  test "should get show" do
    get submitted_kaizen_reports_show_url
    assert_response :success
  end
end
