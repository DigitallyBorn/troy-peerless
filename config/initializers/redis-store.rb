Rails.application.config.cache_store = :redis_store, ENV['REDIS_URL'] || 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
