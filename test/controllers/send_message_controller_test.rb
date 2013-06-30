require 'test_helper'

class SendMessageControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
