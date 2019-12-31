require 'test_helper'

class ReservesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reserves_create_url
    assert_response :success
  end

end
