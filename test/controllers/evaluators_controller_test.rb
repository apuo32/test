require "test_helper"

class EvaluatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get evaluators_show_url
    assert_response :success
  end
end
