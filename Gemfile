source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'uglifier', '>= 1.3.0'
gem 'active_model_serializers', '~> 0.8.3'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'pg'

group :test, :development do
  gem 'rspec-rails'
  gem 'fuubar'
  gem 'capybara'
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'database_cleaner'
  gem 'pry'
  gem 'puma'
  gem 'guard-rspec'
  gem 'rb-fsevent' if `uname` =~ /Darwin/
end

group :development do
  gem 'spring'
  gem "spring-commands-rspec"
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'shoulda-matchers', '~> 2.8.0', require: false
end

group :production do
  gem 'rails_12factor'
end

gem 'devise'
gem 'themoviedb', '0.1.0'
gem 'rottentomatoes', '~> 1.1.3'
gem 'figaro', git: 'https://github.com/laserlemon/figaro.git'
gem 'vacuum'
gem 'goodreads', git: 'https://github.com/heliostatic/goodreads.git'
gem 'rspotify', '~> 1.18.0'
