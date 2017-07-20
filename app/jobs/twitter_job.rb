require 'twitter'
# TODO: move this out maybe?!?!
class TwitterClient
  attr_reader :client

  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_API_SECRET"]
    end
  end
end

class TwitterJob
  def perform
    client.search("#monumentmonitor").each do |tweet|
      tweet.media.each do |media|
        Image.find_by(twitter_id: media.id) ? "" : create_image(tweet, media)
      end
    end
  end



  private

  def create_image(tweet, media)
    twitter_desc = tweet.text
    image_id = media.id
    twitter_id = tweet.id
    url = URI.parse(media.media_url).to_s
    user = tweet.user
    twitter_user = TwitterUser.find_by(twitter_id: user.id) || create_twitter_user(user)
    record_taken = tweet.created_at
    image = Image.new(url: url,
                      twitter_id: twitter_id,
                      source: 'twitter',
                      twitter_user_id: twitter_user.id,
                      record_taken: record_taken,
                      media_id: media_id)
    image.save
  end

  def create_twitter_user(user)
    user_id = user.id
    user_name = user.screen_name
    location = user.geo_enabled? ? user.location : "not given"
    friends_count = user.friends_count
    followers_count = user.followers_count

    twitter_user = TwitterUser.new(
                            twitter_id: user_id,
                            user_name: user_name,
                            location: location,
                            followers_count: followers_count,
                            friends_count: friends_count
     )
     twitter_user.save
     twitter_user
  end

  def client
    @client ||= TwitterClient.new.client
  end
end
