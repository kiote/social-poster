
source 'https://rubygems.org'

gem 'rails', '4.0.0.rc1'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-linkedin'
gem 'omniauth-twitter'

gem 'bootstrap-sass'
gem 'bootstrap-wysihtml5-rails', :require => 'bootstrap-wysihtml5-rails',
                              :git => 'git://github.com/Nerian/bootstrap-wysihtml5-rails.git'
gem 'haml-rails'
gem 'unicorn'

group :production, :staging do
  gem "pg"
  
  # it's about bootstrap's styles
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  
end

group :development, :test do
	gem "sqlite3"
end


group :assets do
  gem 'coffee-rails'
	gem 'sass-rails', '~> 4.0.0.rc1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'protected_attributes'
