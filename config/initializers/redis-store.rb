redis_server = ENV['REDIS_URL'] || 'redis://localhost:6379/0/cache'
Rails.application.config.cache_store = :redis_store, redis_server, { expires_in: 90.minutes }
TroyPeerless::Application.config.session_store :redis_store, servers: redis_server
