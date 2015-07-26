require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get orphans" do
    get :orphans
    assert_response :success
  end

end
