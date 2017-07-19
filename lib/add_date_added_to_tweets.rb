require 'twitter'
require 'twitter_job'

tweets = Image.where(source: 'twitter')

# client = TwitterClient.new.client
#
# tweets.each do |tweet|
#   if client.status(tweet.twitter_id)
#     puts 'not found'
#   else
#     puts 'YAY FOUND!'
#   end
# end
puts tweets.count

tweets_updated = 0
tweets.each do |tweet|
  media_id = tweet.twitter_id
  tweet.media_id = media_id
  tweet.twitter_id = nil
  tweet.save
  tweets_updated += 1
  puts "updated one tweet"
end

puts "          "
puts "          "
puts "updated #{tweets_updated} tweets"
