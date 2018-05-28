# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'activeadmin'
gem 'active_admin_flat_skin', git: "https://github.com/ayann/active_admin_flat_skin.git"
gem 'autoprefixer-rails'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cancancan', '~> 2.0'
gem 'chartkick'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'fat_fingers'
gem 'font-awesome-rails'
gem 'foundation_emails'
gem 'foundation-rails'
gem 'inky-rb', require: 'inky'
gem 'jbuilder', '~> 2.5'
gem 'activerecord_json_validator'
gem 'knock'
gem 'pg', '>= 0.18', '< 2.0'
gem 'premailer-rails'
gem 'postal-rails', '~> 1.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'rest-client'
gem 'sidekiq'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'rspec-rails', '~> 3.7'
  gem 'rubocop', '~> 0.55.0', require: false
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
end

group :development do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-passenger', '>= 0.1.1'
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem "letter_opener"
  gem 'letter_opener_web', '~> 1.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
