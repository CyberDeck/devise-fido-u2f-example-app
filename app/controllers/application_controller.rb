class ApplicationController < ActionController::Base
  # Prepend the verification of the CSRF token before the action chain.
  protect_from_forgery with: :exception, prepend: true
  # All pages are only allowed for authenticated users.
  # Visitor pages will be excepted from this rule explicitly.
  before_action :authenticate_user!
end
