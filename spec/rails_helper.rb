# frozen_string_literal: true


require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  config.filter_sensitive_data('<YOUTUBE_API_KEY>') { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data('<GITHUB_USER_TOKEN>') { ENV['GITHUB_USER_TOKEN'] }
  config.filter_sensitive_data('<CLIENT_ID>') { ENV['CLIENT_ID'] }
  config.filter_sensitive_data('<CLIENT_SECRET>') { ENV['CLIENT_SECRET'] }
  config.filter_sensitive_data('<SENDGRID_PASSWORD>') { ENV['SENDGRID_PASSWORD'] }
  config.filter_sensitive_data('<SENDGRID_USERNAME>') { ENV['SENDGRID_USERNAME'] }
end

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start do
  add_filter "app/channels"
  add_filter "app/jobs"
  add_filter "app/mailers/application_mailer"
  add_filter "app/controllers/application_controller"
  add_filter "spec"
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
