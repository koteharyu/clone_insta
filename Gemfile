source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 5.2.3'
gem 'sqlite3', '~> 1.3.6'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'slim-rails'
gem 'html2slim'
gem 'sorcery'
gem 'rails-i18n', '~> 5.1'
gem 'font-awesome-sass', '< 5.0.13'
gem 'carrierwave'
gem 'mini_magick'
gem 'faker'
gem 'kaminari'
gem 'jquery-rails'
gem 'popper_js'
gem 'config'
gem 'sidekiq', '~> 5.0'
gem 'sinatra'
gem 'meta-tags'
gem 'simplecov'
gem 'pre-commit'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # 今回追加したgems
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'letter_opener_web'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
