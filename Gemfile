source "https://rubygems.org"

ruby "3.0.0"

gem "rails", "~> 7.1.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
# gem "jbuilder"
# gem "redis", ">= 4.0.1"
gem 'devise'
gem 'devise-jwt'
# gem "kredis"
gem "bcrypt", "~> 3.1.7"

gem "bootsnap", require: false
gem "rack-cors"

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'main'
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end

group :development do
end

gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]