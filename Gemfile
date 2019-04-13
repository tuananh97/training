source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.1"

gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", "~> 4.0.0"
gem "bootstrap-datepicker-rails"
gem "bootstrap4-kaminari-views"
gem "bulk_insert"
gem "cancancan", "~> 1.10"
gem "carrierwave", "1.2.2"
gem "ckeditor"
gem "cocoon"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "faker"
gem "figaro"
gem "fog-aws"
gem "font-awesome-rails"
gem "i18n"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick"
gem "mini_racer"
gem "momentjs-rails"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.0"
gem "rails-i18n"
gem "ransack"
gem "rolify"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "sidekiq"
gem "uglifier", ">= 1.3.0"
gem "validates_timeliness", "~> 5.0.0.alpha3"
gem "whenever", require: false

group :development, :test do
  gem "factory_bot_rails", require: false
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 3.6"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "mysql2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "mysql2"
end

group :test do
  gem "faker"
  gem "capybara"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 3.1"
  gem 'database_cleaner', '~> 1.5'
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
