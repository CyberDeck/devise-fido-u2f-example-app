# Load the Rails application.
require_relative 'application'

Rails.application.config.active_record.sqlite3.represent_boolean_as_integer = true

# Initialize the Rails application.
Rails.application.initialize!
