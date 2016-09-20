# frozen_string_literal: true
RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.before(:suite) { Warden.test_mode! }
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new app, browser: :chrome
end

Capybara.default_max_wait_time = 10
