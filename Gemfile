source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
# gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem 'slim-rails', '~> 3.1', '>= 3.1.1'
gem 'devise', '~> 4.9'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails', '~> 6.2'
end

group :development do
  gem "web-console"
  gem 'rubocop', '~> 1.45', '>= 1.45.1', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'rubocop-rspec', '~> 2.10', require: false
  gem 'rubocop-performance', '~> 1.13', require: false
  gem 'letter_opener'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'capybara', '>= 3.26'
  gem 'capybara-email'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
end
