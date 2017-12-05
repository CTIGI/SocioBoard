require File.expand_path('../boot', __FILE__)

require 'rails/all'
Bundler.require(*Rails.groups)

module JuvOffendersDashboard
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.autoload_paths << Rails.root.join("lib")
    config.time_zone = "America/Fortaleza"
    config.i18n.default_locale = :"pt-BR"
    config.i18n.available_locales = %w(pt-BR en)
    config.middleware.use I18n::JS::Middleware
    config.active_job.queue_adapter = :sidekiq
  end
end
