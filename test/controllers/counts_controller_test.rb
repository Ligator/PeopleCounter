require 'test_helper'

class CountsControllerTest < ActionController::TestCase
  test "should get increment" do
    get :increment
    assert_response :success
  end

  test "should get decrement" do
    get :decrement
    assert_response :success
  end

end
