source "https://rubygems.org"

ruby "3.2.2"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'httparty'
gem 'liquid'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
end

group :test do
  gem 'rspec-rails'
  gem 'webmock'
  gem 'redis-rails'
  gem 'factory_bot_rails'
end
