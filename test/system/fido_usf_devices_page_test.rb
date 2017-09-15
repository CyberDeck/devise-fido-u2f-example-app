require "application_system_test_case"

class FidoUsfDevicesPageTest < ApplicationSystemTestCase
  include ApplicationHelper
  
  setup do
    @user = users(:user)
    sign_in_as_user()
    visit edit_user_registration_path
    assert_basics(I18n.t('site.page.settings'))
    # Remove EU Consent banner - some chrome versions complain that it hides the Remove Account button
    within 'div[class="cookies-eu js-cookies-eu"]' do
      click_button "OK"
    end
  end

  def assert_basics(title)
    assert_title full_title(title)
    assert_basic_links(signed_in: true, user: @user)
    assert_translations
  end

  test "settings should allow to register FIDO U2F devices" do
    assert_link I18n.t('devise.registrations.register_2fa')
    click_link I18n.t('devise.registrations.register_2fa')
    
    # Register 2FA Device page
    assert_title full_title(I18n.t('site.page.register_2fa'))
    assert_basic_links(signed_in: true, user: @user)
    assert_translations

    appId  = find_javascript_assignment_for_string(page, 'appId')
    registerRequests = find_javascript_assignment_for_array(page, 'registerRequests')
    assert registerRequests[0]["challenge"]
    token = setup_u2f_with_appid(appId)
    # Inject FIDO U2F registration process values to form and submit it
    set_hidden_field 'response', token[:device].register_response(registerRequests[0]['challenge'])
    execute_script("Rails.fire($('#form-register')[0], 'submit')");
    fill_in 'Name', with: "My new 2FA token"
    click_button I18n.t('devise.registrations.register')
    assert_text I18n.t('fido_usf.flashs.device.registered')
    assert_text 'My new 2FA token'
  end

  #test "sign in should allow to authenticate with valid FIDO U2F devices" do
  #  # Got to root_url to grab appId from browser address bar
  #  visit root_url
  #  appId = execute_script("return window.location.origin")

  #  token = setup_u2f_with_appid(appId)

  #  binding.pry
  #  @user = create_user({usf_device: token})
  #  puts(@user)
  #  sign_in_as_user()

  #  take_screenshot

  #end
end
