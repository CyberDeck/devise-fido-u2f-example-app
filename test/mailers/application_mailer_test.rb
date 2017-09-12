require 'test_helper'
 
class ApplicationMailerTest < ActionMailer::TestCase
  test "basic settings" do
    assert ApplicationMailer.default[:from], "from@example.com"
    assert ApplicationMailer._layout?
  end
end
