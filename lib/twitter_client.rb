require 'twitter'
class TwitterClient
  attr_reader :client

  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_API_SECRET"]
    end
  end
end