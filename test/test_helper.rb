require 'simplecov'
SimpleCov.start 'rails' do
  # enable_coverage :branch
  add_filter "/vendor/"
  merge_timeout = 3600 # only reset coverage stats after 1 hour of inactivity
end

require 'coveralls'
require 'rake'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

if Rake.application.top_level_tasks.include? 'test:system'
  SimpleCov.command_name "test:system"
else
  SimpleCov.command_name "test"
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'
require 'support/bullet_test'
require 'support/integration'
require 'support/test_case'
require 'minitest/reporters'
Minitest::Reporters::use!

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

