require "redis"
$redis = Redis.new(:url => (ENV["REDIS_URL"] || 'redis://127.0.0.1:6379'))
$redis_cache = Redis::Namespace.new("ops", :redis => $redis)
$redis_store = Redis::Namespace.new("cloudops::Store", :redis => $redis)

