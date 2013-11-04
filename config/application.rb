
require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module SocialPoster
  class Application < Rails::Application
		
		config.generators do |g|
			g.test_framework :rspec,
				:fixtures => true,
				:view_specs => false,
				:helper_specs => false,
				:routing_specs => false,
				:controller_specs => true,
				:request_specs => true
			g.fixture_replacement :factory_girl, :dir => "spec/factories"
		end

    config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += Dir["#{config.root}/app/models/mutations/**/"]
    
  end
end
