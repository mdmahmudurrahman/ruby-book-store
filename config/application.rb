# frozen_string_literal: true
require_relative 'boot'

require 'rails'
require 'sprockets/railtie'
require 'active_job/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_mailer/railtie'
require 'action_controller/railtie'

# Pick the frameworks you want:
# require "action_cable/engine"
# require "action_mailer/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require *Rails.groups

module RubyBookStore
  class Application < Rails::Application
    config.generators do |generators|
      generators.test_framework :rspec
      generators.factory_girl dir: 'spec/factories'
    end

    Dir[Rails.root.join 'lib', 'rails_admin', '**'].each { |file| require file }

    config.action_controller.include_all_helpers = false
    config.autoload_paths << Rails.root.join('app', 'forms', 'users')
    config.autoload_paths << Rails.root.join('app', 'decorators', 'users')
    config.i18n.load_path += Dir[Rails.root.join 'config', 'locales', '**', '*.{rb,yml}']
  end
end
