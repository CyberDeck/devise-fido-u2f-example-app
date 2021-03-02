require 'active_support/test_case'

class ActiveSupport::TestCase
  include BulletTest
  # Load fixtures
  fixtures :all

  def login_user(user, password: 'abcdefgh')
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { user: { email: user.email, password: password } }
    assert warden.authenticated?(:user)
    assert_equal warden.user, user
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'pages/home'
  end

  def user_token(user, password: 'abcdefgh')
    assert_nil user.authentication_token
    assert_nil user.authentication_token_at
    post api_token_path(), params: {format: 'json', email: user.email, password: 'abcdefgh'}
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal user.reload.authentication_token, json['token']
    assert_not_nil user.authentication_token_at
    return json['token']
  end

end
