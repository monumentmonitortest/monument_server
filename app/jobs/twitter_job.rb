# create job to scrape twitter
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

class TwitterJob
  def perform

    client.search("#upcyclegarden").each do |tweet|
      tweet.media.each do |media|
        if !Image.find_by(twitter_id: media.id)
          twitter_desc = tweet.text
          image_id = media.id
          url = URI.parse(media.media_url).to_s
          user = tweet.user


          twitter_user = TwitterUser.find_by(twitter_id: user.id)

          if !twitter_user
            user_id = user.id
            user_name = user.screen_name
            user.geo_enabled? ? false : location = user.location
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
           end

           image = Image.new(url: url, twitter_id: image_id, site: 'twitter', twitter_user_id: twitter_user.id)
           image.save
          end
        end
      end
    end

  private

  def client
    @client ||= TwitterClient.new.client
  end
end
