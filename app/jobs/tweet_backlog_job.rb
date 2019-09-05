require 'twitter'
require 'twitter_client.rb'
require 'open-uri'

DATE = '05/08/2019'.to_date

class TweetBacklogJob
  def perform
    tweets = File.read('./lib/tweets.json')
    tweet_json = JSON.parse(tweets)
    tweet_json.each do |tweet|
      tweet_id = tweet["tweet_id"]
        begin
        tweet_object = client.status(tweet_id)
        if !tweet_object.retweet? && tweet_object.media? && tweet_object.created_at < DATE
          puts "tweet is ok"
          images = tweet_object.media
          images.each do |image|
            create_submission(tweet_object, image)
          end
        else
          puts "tweet is not ok"
        end
        rescue Twitter::Error::TooManyRequests => error
          puts "too many requests"

        rescue Twitter::Error::Forbidden => error
          puts "not allowed to see this tweet"
        end
    end
  end

  private

  def create_submission(tweet, media)
    twitter_desc = tweet.text
    type_specific_id = media.id.to_s
    twitter_user = tweet.user.id.to_s
    record_taken = tweet.created_at
    image_url = media.media_url

    unless Type.find_by(type_specific_id: type_specific_id)
      registration = Registration.new(reliable: false, 
        site_id: site_id, 
        image_file: image_url, 
        comment: twitter_desc,
        record_taken: record_taken, 
        type_name: 'TWITTER', 
        insta_username: '',
        email_address: '',
        number: '',
        twitter_username: twitter_user, 
        type_specific_id: type_specific_id
      )
      
      if registration.save
        puts 'saved successffully'
      else
        puts "there was an error: #{registration.error}"
      end
    else
      puts "submission already exists"
    end
  end

  def client
    @client ||= ::TwitterClient.new.client
  end

  def site_id
    @site_id ||= Site.find_by(name: 'Twitter unsorted').id
  end
end