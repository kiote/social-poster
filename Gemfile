
source 'https://rubygems.org'

#ruby '2.0.0'

gem 'rails', '4.0.0'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-linkedin'
gem 'omniauth-tumblr'
gem 'omniauth-twitter'

gem 'fb_graph'
gem 'linkedin'
gem 'vkontakte_api', '~> 1.1'

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'bootstrap-sass'
# gem 'bootstrap-sass', '2.3.2.0'
#gem 'bootstrap-wysihtml5-rails', :require => 'bootstrap-wysihtml5-rails',
#                              :git => 'git://github.com/Nerian/bootstrap-wysihtml5-rails.git'
gem 'haml-rails'
gem 'unicorn'
gem 'will_paginate'

group :production, :staging do
  gem 'pg'
  
  # it's about bootstrap's styles
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  
end

group :development, :test do

	gem "sqlite3"
	gem 'rspec-rails'
	gem 'factory_girl_rails'

end

group :test do

	gem 'faker'
	gem 'capybara'
	gem 'guard-rspec'
	gem 'launchy'

	#gem 'webmock'
	#gem 'fakeweb'
	#gem 'vcr'
	
	gem 'capybara-webkit'

# чёто дурака валяют при litesql3
#	gem 'cucumber-rails'
#	gem 'database_cleaner', github: 'bmabey/database_cleaner'

end


gem 'coffee-rails'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails'
gem 'turbolinks'
