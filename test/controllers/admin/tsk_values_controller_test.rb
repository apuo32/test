require "test_helper"

class Admin::TskValuesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_tsk_values_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_tsk_values_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_tsk_values_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_tsk_values_show_url
    assert_response :success
  end
end
