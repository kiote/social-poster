# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require "capybara/rspec"
require "capybara/rails"
Capybara.javascript_driver = :webkit

#require 'webmock/rspec'
#require 'webmock/cucumber'

#require 'vcr'

#VCR.configure do |c|
	#c.cassette_library_dir = 'vcr_cassettes'
	#c.hook_into :webmock
	#c.configure_rspec_metadata!
	#c.ignore_localhost = true
	#c.default_cassette_options = { :record => :new_episodes }
	#c.stub_with :webmock
#end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

OmniAuth.config.test_mode = true

omniauth_hash = { 'uid' => '12345', 'nickname' => 'testuser', 'credentials' => { 'token' => 'umad', 'secret' => 'bro?' } }

OmniAuth.config.add_mock(:twitter, omniauth_hash)
OmniAuth.config.add_mock(:foursquare, omniauth_hash)
OmniAuth.config.add_mock(:facebook, omniauth_hash.merge({'nickname' => 'Mr Herpy Derpy Pants'}))

RSpec.configure do |config|
	
	config.include Capybara::DSL
	#config.include OauthMocking
	#config.include(OauthMocking, :type => :feature)
	config.include(OauthMocking, :type => :request)


	#config.extend VCR::RSpec::Macros

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

	config.before(:suite) do
		DatabaseCleaner.strategy = :truncation
	end
	config.before(:each) do
		DatabaseCleaner.start
	end
	config.after(:each) do
		DatabaseCleaner.clean
	end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

end
