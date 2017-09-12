require 'test_helper'

class ProtectedPagesTest  < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "visit without 2fa" do
    visit protected_pages_path()
    assert_no_text 'secret page'
  end

end
