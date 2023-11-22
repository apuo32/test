require "test_helper"

class Admin::EffectAmountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_effect_amounts_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_effect_amounts_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_effect_amounts_edit_url
    assert_response :success
  end

  test "should get show" do
    get admin_effect_amounts_show_url
    assert_response :success
  end
end
