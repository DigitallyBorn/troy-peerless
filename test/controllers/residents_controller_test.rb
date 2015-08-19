require 'test_helper'

class ResidentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get me" do
    get :me
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end