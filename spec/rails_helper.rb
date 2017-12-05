ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "capybara/rails"
require "pundit/rspec"
require "capybara/poltergeist"
require 'simplecov'
require "capybara/rspec"
require "vcr"

ActiveRecord::Migration.maintain_test_schema!
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end

Capybara.current_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

if ENV["REAL_REQUESTS"]
  VCR.turn_off!(ignore_cassettes: true)
  WebMock.allow_net_connect!
end

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
end


Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

RSpec.configure do |config|

  # config.include FontAwesome::Rails::IconHelper

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.infer_spec_type_from_file_location!
  config.include Capybara::DSL, :type => :feature
  config.include FactoryBot::Syntax::Methods
  config.include ApplicationHelper
  config.include SpecHelpers::ControllerHelpers
  config.include SpecHelpers::Authentication

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
