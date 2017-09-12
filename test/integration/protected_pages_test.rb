require 'test_helper'

class ProtectedPagesTest  < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "visit without login" do
    visit protected_pages_path()
    assert_no_text 'Protected Page'
  end

  test "visit with login" do
    sign_in_as_user
    visit protected_pages_path()
    assert_text 'Protected Page'
  end

  test "visit with wrong login" do
    sign_in_as_user(password: "notmypassword")
    visit protected_pages_path()
    assert_no_text 'Protected Page'
  end
end
