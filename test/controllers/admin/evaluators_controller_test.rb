require "test_helper"

class Admin::EvaluatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_evaluators_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_evaluators_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_evaluators_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_evaluators_show_url
    assert_response :success
  end
end
