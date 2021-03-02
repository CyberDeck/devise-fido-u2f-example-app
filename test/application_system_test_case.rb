require "test_helper"
require "webdrivers"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
 #driven_by :selenium, using: :chrome, screen_size: [1400, 900], options: { args: %w[headless disable-gpu no-sandbox] }
 driven_by :selenium, using: :chrome, screen_size: [1400, 900]
end
