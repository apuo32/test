require "test_helper"

class Admin::CalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_calendars_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_calendars_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_calendars_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_calendars_show_url
    assert_response :success
  end
end
