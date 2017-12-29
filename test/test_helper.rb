
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start 'rails' do
  add_filter "/vendor/"
end
if Rake.application.top_level_tasks.include? 'test:system'
  SimpleCov.command_name "test:system"
else
  SimpleCov.command_name "test"
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'
require 'capybara/poltergeist'
require 'support/integration'

Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, window_size: [1400, 1000])
end
Capybara.javascript_driver = :poltergeist

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
