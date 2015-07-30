require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get apidoc" do
    get :apidoc
    assert_response :success
  end

  test "should get challenge" do
    get :challenge
    assert_response :success
  end

end
