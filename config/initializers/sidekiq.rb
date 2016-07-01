Sidekiq.configure_client do |config|
  Encoding.default_external="UTF-8"
  Encoding.default_internal="UTF-8"
end

Sidekiq.configure_server do |config|
  Encoding.default_external="UTF-8"
  Encoding.default_internal="UTF-8"
end
