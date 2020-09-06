# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'

gem 'i18n'
gem 'config'

gem 'activesupport', require: false

gem 'rack-ougai'
gem 'amazing_print' # нужен для ouagi!

gem 'dry-initializer'
gem 'dry-validation'

group :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
end