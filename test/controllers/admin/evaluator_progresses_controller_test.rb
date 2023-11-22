require "test_helper"

class Admin::EvaluatorProgressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_evaluator_progresses_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_evaluator_progresses_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_evaluator_progresses_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_evaluator_progresses_show_url
    assert_response :success
  end
end
