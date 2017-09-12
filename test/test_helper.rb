
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start 'rails' do
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActionDispatch::IntegrationTest

  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  def teardown
    take_failed_screenshot
    Capybara.reset_sessions!
    Capybara.use_default_driver
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
end

class ActiveSupport::TestCase

  # Load fixtures
  fixtures :all

end
