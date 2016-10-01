# frozen_string_literal: true
Rails.application.configure do
  config.eager_load = false
  config.cache_classes = false
  config.consider_all_requests_local = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.action_controller.perform_caching = true

    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.cache_store = :null_store
    config.action_controller.perform_caching = false
  end

  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = {
    host: 'localhost', port: 3000
  }

  config.assets.debug = true
  config.assets.quiet = true

  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
