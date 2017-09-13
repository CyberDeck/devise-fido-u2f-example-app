require "application_system_test_case"

class SettingsPageTest < ApplicationSystemTestCase
  include ApplicationHelper
  
  setup do
    @user = users(:user)
    sign_in_as_user()
    visit edit_user_registration_path
    assert_basics(I18n.t('site.page.settings'))
  end

  def assert_basics(title)
    assert_title full_title(title)
    assert_basic_links(signed_in: true, user: @user)
    assert_translations
  end


  test "settings page changing email" do
    assert_no_changes '@user.reload.email' do
      fill_in User.human_attribute_name(:email), with: 'new@example.com'
      click_button I18n.t('devise.registrations.update')
    end
    assert_changes '@user.reload.email' do
      fill_in User.human_attribute_name(:email), with: 'new@example.com'
      fill_in User.human_attribute_name(:current_password), with: 'abcdefgh'
      click_button I18n.t('devise.registrations.update')
    end
    assert @user.reload.email, 'new@example.com'
    take_screenshot
  end

  test "settings page changing password" do
    assert_no_changes '@user.reload.encrypted_password' do
      fill_in User.human_attribute_name(:password), with: 'mynewpassword'
      fill_in User.human_attribute_name(:password_confirmation), with: 'mynewpassword'
      click_button I18n.t('devise.registrations.update')
    end
    assert_changes '@user.reload.encrypted_password' do
      fill_in User.human_attribute_name(:password), with: 'mynewpassword'
      fill_in User.human_attribute_name(:password_confirmation), with: 'mynewpassword'
      fill_in User.human_attribute_name(:current_password), with: 'abcdefgh'
      click_button I18n.t('devise.registrations.update')
    end
    click_link I18n.t('devise.sessions.sign_out')
    sign_in_as_user(password: 'mynewpassword23')
  end
end
