require 'test_helper'

class MerchantssessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get merchantssessions_new_url
    assert_response :success
  end

end
