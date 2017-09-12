require "application_system_test_case"

class SiteLayoutsTest < ApplicationSystemTestCase
  include ApplicationHelper

  def assert_basics(title)
    assert_title full_title(title)
    assert_basic_links
    assert_translations
  end

  test "Home page" do
    visit root_path 
    assert_basics('')
    # Test layout for main content
    assert_selector 'body main div.jumbotron div.container'
  end 

  test "Sign in page" do
    visit root_path
    click_link 'Sign in'
    assert_title full_title('Sign in')
    assert_basics('')
    assert_text I18n.t('devise.sessions.sign_in')
    assert_field User.human_attribute_name(:email), type: 'email'
    assert_field User.human_attribute_name(:password), type: 'password'
    assert_field User.human_attribute_name(:remember_me), type: 'checkbox'
    assert_button I18n.t('devise.sessions.sign_in')
    assert_link I18n.t('devise.passwords.forgot_password'), href: new_user_password_path()
  end 

end
