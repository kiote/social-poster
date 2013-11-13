source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'

gem 'omniauth'
gem 'omniauth-oauth2'

gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-tumblr'
gem 'omniauth-twitter'

gem 'fb_graph'
gem 'linkedin'

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'bootstrap-sass'
gem 'bootstrap-wysihtml5-rails'

gem 'haml-rails'
gem 'unicorn'
gem 'will_paginate'

gem 'mutations'

group :production, :staging do
  gem 'pg'
  
  # it's about bootstrap's styles
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  
end

group :development, :test do

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem "sqlite3"

end

group :test do

	gem "vcr"
	gem "webmock"
	gem "fakeweb"

	gem 'faker'
	gem 'capybara'
	gem 'guard-rspec'

	gem 'capybara-webkit'

	gem 'cucumber-rails', require: false
	gem 'database_cleaner'

end


gem 'coffee-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'turbolinks'
gem 'jquery-rails'
