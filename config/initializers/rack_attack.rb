# class Rack::Attack

#   # `Rack::Attack` is configured to use the `Rails.cache` value by default,
#   # but you can override that by setting the `Rack::Attack.cache.store` value
#   Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

#   # Allow all local traffic
#   whitelist('allow-localhost') do |req|
#     # Here put the IPs that you want to whitelist, like in WATG days
#     '127.0.0.1' == req.ip || '::1' == req.ip
#   end

#   # Allow an IP address to make 5 requests every 5 seconds
#   throttle('req/ip', limit: 5, period: 5) do |req|
#     req.ip
#   end

#    # Send the following response to throttled clients
#    self.throttled_response = ->(env) {
#     retry_after = (env['rack.attack.match_data'] || {})[:period]
#     [
#       429,
#       {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
#       [{error: "Throttle limit reached. Retry later. Maybe fuck off?"}.to_json]
#     ]
#   }
# end