require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TroyPeerless
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.secret_token = ENV['SECRET_TOKEN'] || '90bd41341e3773ec9a11fcb22e99f7ba01fe942c40993613334da60a9e8cd241ce3bfdd6704b6ce4ebe665331165f2f86cc61872422293a5f293318db9f8e5c8'

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.facebook_appid = Rails.application.secrets.facebook_appid || ENV['FACEBOOK_APPID']
    config.facebook_secret = Rails.application.secrets.facebook_secret || ENV['FACEBOOK_SECRET']
  end
end
