# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_troy-peerless_session'
TroyPeerless::Application.config.session_store :redis_store, servers: ENV['REDIS_URL'] || 'redis://localhost:6379/0/cache'
