require 'twitter'
require 'twitter_client.rb'
require 'open-uri'

class TwitterJob
  def perform
    client.search("#monumentmonitor").each do |tweet|
      if !tweet.retweet? && tweet.media.present?
        tweet.media.each do |media|
          Type.find_by(type_specific_id: media.id.to_s) ? "" : create_submission(tweet, media)
        end
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
  end

  def client
    @client ||= ::TwitterClient.new.client
  end

  def site_id
    @site_id ||= Site.find_by(name: 'Twitter unsorted').id
  end
end
