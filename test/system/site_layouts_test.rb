require "application_system_test_case"

class SiteLayoutsTest < ApplicationSystemTestCase
  include ApplicationHelper

  test "Home page" do
    visit root_path 
    assert_title full_title('')
    assert_basic_links
    assert_translations
    # Test layout for main content
    #assert_select 'body main div.jumbotron div.container'
  end 

end
