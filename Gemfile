source 'https://rubygems.org'
ruby "2.2.3"

gem 'rails', '>= 5.0.0.beta3', '< 5.1'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'redis', '~> 3.0'
gem 'pg'
gem 'responders'
gem 'figaro'
gem 'bower-rails'
gem 'kaminari', git: "git://github.com/amatsuda/kaminari.git", branch: 'master'
gem 'ransack', github: 'activerecord-hackery/ransack'
gem "font-awesome-rails"
gem "paloma"
gem "gon"
gem "i18n-js", ">= 3.0.0.rc11"
gem "sidekiq", "~> 4.1.0"
gem 'whenever', :require => false

group :development, :test do
  gem 'pry-byebug'
  gem 'faker'
  gem "fuubar"
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'enumerize-matchers'
  gem 'quiet_assets'
  gem 'jasmine-rails'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'poltergeist'
  gem 'webmock'
  gem 'vcr'
  gem 'timecop'
  gem 'email_spec'
  gem "fuubar"
  gem 'rspec-activemodel-mocks'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'spring'
  gem "mina", "~> 0.3"
  gem "mina-multistage", "~> 1.0", require: false
  gem "mina-sidekiq"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
