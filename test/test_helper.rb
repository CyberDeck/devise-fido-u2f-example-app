
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
require 'support/integration'

class ActionDispatch::SystemTestCase
  def teardown
    take_failed_screenshot
    super
  end
end

class ActiveSupport::TestCase

  # Load fixtures
  fixtures :all

end
