require 'test_helper'

class ProtectedPagesTest  < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
  end

  def warden
    request.env['warden']
  end

  test "visit without login" do
    get protected_pages_path()
    assert_redirected_to new_user_session_path()
  end

  test "visit with login" do
    login_user @user
    get protected_pages_path()
    assert_template 'protected_pages/show'
  end

  test "visit with wrong login" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { user: { email: @user.email, password: "notmypassword" } }
    assert_not warden.authenticated?(:user)
    assert_nil warden.user
  end
end
