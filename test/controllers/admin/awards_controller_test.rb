require "test_helper"

class Admin::AwardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_awards_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_awards_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_awards_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_awards_show_url
    assert_response :success
  end
end
