require "test_helper"

class ListKaizenReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get list_kaizen_reports_index_url
    assert_response :success
  end

  test "should get show" do
    get list_kaizen_reports_show_url
    assert_response :success
  end
end
