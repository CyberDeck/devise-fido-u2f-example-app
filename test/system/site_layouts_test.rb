require "application_system_test_case"

class SiteLayoutsTest < ApplicationSystemTestCase
  include ApplicationHelper
  
  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

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
    assert_text "Lame"
  end 

  test " Sign in page and tab register" do
    visit root_path
    within "header" do
      click_link I18n.t('devise.sessions.sign_in')
    end
    assert_title full_title(I18n.t('site.page.sign_in'))
    assert_basics('')
    within "main" do
      assert_text I18n.t('devise.sessions.sign_in')
      assert_text I18n.t('devise.registrations.register')
      # Sign_in
      assert_field User.human_attribute_name(:email), type: 'email'
      assert_field User.human_attribute_name(:password), type: 'password'
      assert_field User.human_attribute_name(:remember_me), type: 'checkbox'
      assert_button I18n.t('devise.sessions.sign_in')
      assert_link I18n.t('devise.passwords.forgot_password'), href: new_user_password_path()

      # Register
      click_link I18n.t('devise.registrations.register')
      assert_field User.human_attribute_name(:email), type: 'email'
      assert_field User.human_attribute_name(:password), type: 'password'
      assert_field User.human_attribute_name(:password_confirmation), type: 'password'
      assert_button I18n.t('devise.registrations.register')
    end
  end 

  test "Register page and tab sign_in" do
    visit root_path
    within "header" do
      click_link I18n.t('devise.registrations.register')
    end
    assert_title full_title(I18n.t('site.page.register'))
    assert_basics('')
    within "main" do
      assert_text I18n.t('devise.sessions.sign_in')
      assert_text I18n.t('devise.registrations.register')
      # Sign_in
      assert_field User.human_attribute_name(:email), type: 'email'
      assert_field User.human_attribute_name(:password), type: 'password'
      assert_field User.human_attribute_name(:password_confirmation), type: 'password'
      assert_button I18n.t('devise.registrations.register')

      # Register
      click_link I18n.t('devise.sessions.sign_in')
      assert_field User.human_attribute_name(:email), type: 'email'
      assert_field User.human_attribute_name(:password), type: 'password'
      assert_field User.human_attribute_name(:remember_me), type: 'checkbox'
      assert_button I18n.t('devise.sessions.sign_in')
      assert_link I18n.t('devise.passwords.forgot_password'), href: new_user_password_path()
    end
  end 

  test "Sign_in page with wrong email and password" do
    visit root_path
    within "header" do
      click_link I18n.t('devise.sessions.sign_in')
    end
    assert_title full_title(I18n.t('site.page.sign_in'))
    assert_basics('')
    fill_in User.human_attribute_name(:email), with: 'UnknownUser@notexisting.com'
    fill_in User.human_attribute_name(:password), with: 'notmyrealpassword'
    click_button I18n.t('devise.sessions.sign_in')
    assert_text I18n.t('devise.failure.invalid', authentication_keys: User.human_attribute_name(:email))
  end

  test "Sign_in page with valid user and sign_out" do
    visit root_path
    within "header" do
      click_link I18n.t('devise.sessions.sign_in')
    end
    assert_title full_title(I18n.t('site.page.sign_in'))
    assert_basics('')
    fill_in User.human_attribute_name(:email), with: 'user@example.com'
    fill_in User.human_attribute_name(:password), with: 'abcdefgh'
    click_button I18n.t('devise.sessions.sign_in')
    assert_text I18n.t('devise.sessions.signed_in')
    assert_basic_links(signed_in: true)
    within "header" do
      click_link I18n.t('devise.sessions.sign_out')
    end
    assert_text I18n.t('devise.sessions.signed_out')
  end

end
