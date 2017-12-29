source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Bootstrap 4
gem 'bootstrap', '4.0.0.beta2.1'
# Bootstrap 4 forms (currently only from a Work-in-Progress branch)
#gem "bootstrap_form", git: "https://github.com/bootstrap-ruby/rails-bootstrap-forms.git", branch: "bootstrap-v4"
gem "bootstrap_form", github: "cyberdeck/rails-bootstrap-forms", branch: "bootstrap-v4"
gem 'jquery-rails'
# Serve static pages
gem 'high_voltage'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# EU Cookies Consent
gem 'cookies_eu'
# Devise for user registration and authentication
gem 'devise'
gem 'devise_fido_usf'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'forgery'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'coveralls'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'better_errors'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'thin'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
