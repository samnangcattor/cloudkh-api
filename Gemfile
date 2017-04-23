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

group :development, :test do
  gem "byebug", platform: :mri
end

group :assets do
  gem "sass-rails", "~> 5.0"
  gem "uglifier", ">= 1.3.0"
  gem "coffee-rails", "~> 4.2"
end

group :development do
  gem "rubocop", "~> 0.40.0", require: false
  gem "rubocop-checkstyle_formatter", "~> 0.2.0", require: false
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
