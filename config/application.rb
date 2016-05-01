require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SCRadio
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Begin things I added
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('serializers')

    config.browserify_rails.source_map_environments << 'development'
    config.browserify_rails.commandline_options = '-t [reactify --everything ] -t [ babelify --presets [ es2015 ] --extensions .jsx .js ]'

    config.cache_store = :readthis_store, {
        expires_in: 2.weeks.to_i,
        namespace: 'cache',
        redis: { URL: ENV.fetch('REDIS_URL'), driver: :hiredis }
    }

    Readthis.fault_tolerant = true
  end
end
