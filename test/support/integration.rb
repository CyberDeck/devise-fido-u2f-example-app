require 'action_dispatch/testing/integration'

class ActionDispatch::IntegrationTest
  # Make `assert_*` methods behave like Minitest assertions
  #include Capybara::Minitest::Assertions
  include BulletTest

  def teardown
    Capybara.reset_sessions!
    super
  end

  # Add more helper methods to be used by all tests here...
  def assert_translations
    assert_no_selector 'span.translation_missing'
    assert_no_text 'translation missing:'
  end

  def assert_basic_links(signed_in: false, user: nil)
    within "header" do
      assert_link 'Home', href: root_path
      if signed_in
        assert_no_link 'Sign in', href: new_user_session_path
        assert_no_link 'Register', href: new_user_registration_path
        assert_link 'Sign out', href: destroy_user_session_path
        # Gravatar is not loaded during test and thus not visible
        assert_selector "a[href='#{edit_user_registration_path}'] img", visible: false 
      else
        assert_link 'Sign in', href: new_user_session_path
        assert_link 'Register', href: new_user_registration_path
        assert_no_link 'Sign out', href: destroy_user_session_path
        assert_no_selector "a[href='#{edit_user_registration_path}'] img", visible: false 
      end
    end
  end

  def set_hidden_field(name, value)
    execute_script("return $('input[name=#{name}]')[0].value = '#{value}';")
  end

  def submit_form!(locator)
    form = page.find(locator)
    class << form
      def submit!
        Capybara::RackTest::Form.new(driver, native).submit({})
      end
    end
    form.submit!
  end

  def find_javascript_assignment_for_array(page, variable)
    js = page.all('body script', visible: false)[0].text(:all)
    array = js.gsub(/.*#{variable} = ([^;]+).*/,'\1').to_s
    return JSON.parse(array)
  end

  def find_javascript_assignment_for_string(page, variable)
    js = page.all('body script', visible: false)[0].text(:all)
    return js.gsub(/.*#{variable} = "([^"]+).*/,'\1').to_s
  end

  def create_u2f_device(user, key_handle, public_key, certificate, attributes={})
    attrib = {
      user: user,
      name: 'Unnamed 1',
      key_handle: key_handle,
      public_key: public_key,
      certificate: certificate,
      counter: 0,
      last_authenticated_at: Time.now}.update(attributes)
    FidoUsf::FidoUsfDevice.create!(attrib)
  end

  def sign_in_as_user(options={}, &block)
    visit_with_option options[:visit], new_user_session_path
    within 'div[id="sign-in"] form' do
      fill_in 'Email', with: options[:email] || 'user@example.com'
      fill_in 'Password', with: options[:password] || 'abcdefgh'
      check 'Remember me' if options[:remember_me] == true
      yield if block_given?
      click_button 
    end
  end

  def setup_u2f_with_appid(app_id)
    device = U2F::FakeU2F.new(app_id)
    key_handle = U2F.urlsafe_encode64(device.key_handle_raw)
    certificate = Base64.strict_encode64(device.cert_raw)
    public_key = device.origin_public_key_raw
    {device: device, key_handle: key_handle, certificate: certificate, public_key: public_key}
  end

  protected

    def visit_with_option(given, default)
      case given
      when String
        visit given
      when FalseClass
        # Do nothing
      else
        visit default
      end
    end
end
