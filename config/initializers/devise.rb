Devise.setup do |config|
  config.secret_key = '2314ee65e2bfbf51e3fde7ca0c71f13ef19c762d7a9c292595902f09c24caec07700ba387ae43480d05967b53d9162d0db8b27a60e0a36ff03bfcf8df21e4820'

  config.mailer_sender = 'tempojus@vicegov.ce.gov.br'

  config.mailer = 'CustomDeviseMailer'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.timeout_in = 12.hour

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  Rails.application.config.to_prepare do
    Devise::SessionsController.layout "devise_sessions"
    Devise::PasswordsController.layout "devise_sessions"
  end
end
