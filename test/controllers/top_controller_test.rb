require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get top_top_url
    assert_response :success
  end

end
