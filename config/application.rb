require_relative "boot"

require "rails/all"
require "google/apis/drive_v3"
require "googleauth"
require "googleauth/stores/file_token_store"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CloudApi
  class Application < Rails::Application
    config.middleware.use Rack::Cors do
      allow do
        origins "*"
        resource "*",
          headers: :any,
          expose: ["access-token", "expiry", "token-type", "uid", "client"],
          methods: [:get, :post, :options, :delete, :put],
          credentials: true
      end
    end
  end
end
