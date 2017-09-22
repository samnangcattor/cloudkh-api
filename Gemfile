source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"

# Deploy server on product
gem "puma", "~> 3.0"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"

# Use mysql as the database for Active Record
gem "mysql2", "0.3.21"

# Support
gem "dotenv-rails", "~> 2.1"
gem "config", "~> 1.0"

# Protect CORS
gem "rack-cors", "0.4.0", require: "rack/cors"

# Google api
gem "google-api-client", "~> 0.10.3"

# pagination
gem "kaminari", "~> 0.16.3"

# cache
gem "redis", "~> 3.3", ">= 3.3.1"

group :development, :test do
  gem "byebug", platform: :mri
end

group :assets do
  gem "sass-rails", "~> 5.0"
  gem "uglifier", ">= 1.3.0"
  gem "coffee-rails", "~> 4.2"
end

group :development do
  gem "faker", "~> 1.6", ">= 1.6.3"
  gem "pry-rails", "~> 0.3.4"
  gem "unicode-display_width", "~> 0.1.1"
  gem "pry", "~> 0.10.3"
  gem "rubocop", "~> 0.36.0", require: false
  gem "rubocop-checkstyle_formatter", "~> 0.2.0", require: false
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "awesome_print", "~> 1.7"
  gem "hirb", "~> 0.7.3"
  gem "hirb-unicode", "~> 0.0.5"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
