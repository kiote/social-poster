
ENV['RAILS_ENV'] = 'test'

require './config/environment'

require 'minitest/spec'

require 'rspec/rails'
require 'capybara'

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

Spinach.hooks.before_scenario{ DatabaseCleaner.clean }
