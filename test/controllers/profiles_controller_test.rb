require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_profile" do
    get profiles_edit_profile_url
    assert_response :success
  end
end
