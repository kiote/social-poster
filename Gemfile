source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'

gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-linkedin'
gem 'omniauth-tumblr'
gem 'omniauth-tumblr'
gem 'omniauth-twitter'

gem 'fb_graph'
gem 'linkedin'
gem 'vkontakte_api', '~> 1.1'

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'bootstrap-sass'
gem 'bootstrap-wysihtml5-rails'

gem 'haml-rails'
gem 'unicorn'
gem 'will_paginate'

gem 'mutations'

gem 'mysql2'

group :production, :staging do
  gem 'pg'
  
  # it's about bootstrap's styles
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  
end

group :development, :test do

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem "spinach-rails"

  gem "sqlite3"

end

group :test do

	gem "vcr"
	gem "webmock", "< 1.12"
	gem "fakeweb"

	gem 'faker'
	gem 'capybara'
	gem 'guard-rspec'
	#gem 'launchy'

	gem 'capybara-webkit'

	gem 'cucumber-rails', require: false
  
  gem 'database_cleaner', '<= 1.0.1'
  
  gem "spinach"

end


gem 'coffee-rails'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails'
gem 'turbolinks'

