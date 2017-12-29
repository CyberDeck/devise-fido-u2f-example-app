require "application_system_test_case"

class SiteLayoutsTest < ApplicationSystemTestCase
  include ApplicationHelper
  
  def assert_basics(title)
    assert_title full_title(title)
    assert_basic_links
    assert_translations
  end

  test "Home page show EU cookies consent banner" do
    visit root_path 
    assert_basics('')
    # Test layout for main content
    assert_text 'Cookies help us deliver our services.'
    assert_selector 'div[class="cookies-eu js-cookies-eu"]'
    within 'div[class="cookies-eu js-cookies-eu"]' do
      assert_button "OK"
      assert_link "Learn more", href: page_path('cookies')
      click_button "OK"
    end
    visit root_path 
    assert_no_text 'Cookies help us deliver our services.'
    assert_no_selector 'div[class="cookies-eu js-cookies-eu"]'
  end 

end
