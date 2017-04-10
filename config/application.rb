require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NykApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
<<<<<<< HEAD
    config.cache_store = :redis_store, ENV["REDIS_URL"], { expires_in: 90.minutes}

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :expose => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          :methods => [:get, :post, :options, :delete, :put, :patch]
      end
    end
=======
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931

    config.generators do |g|
      g.javascript_engine :js
    end

  end
end
