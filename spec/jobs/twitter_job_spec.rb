require 'rails_helper'

RSpec.describe TwitterJob, type: :job do
	describe "perform" do
		let!(:site) { create(:site, name: 'Twitter unsorted')}

		before do
			user_object = double('user object', id: 123)
			media_object = double('tweet media object', id: 456, media_url: 'https://www.monumentmonitor.co.uk/static/media/ness.2adde48e.jpg')
			tweet_object = double('tweet object', media: [media_object], retweet?: false, text: 'tweet text', user: user_object, created_at: Date.today )
      twitter_client = double("client", search: [tweet_object])
      # twitter_instance = double("twitter", client: client)
      TwitterClient.any_instance.stub(:client).and_return(twitter_client)
		end
		
		subject { described_class.new.perform }
		
		it "saves tweet" do
			subject
			expect(Submission.last.type.comment).to eq('tweet text') 
			expect(Submission.last.record_taken).to eq(Date.today)
		end

		it "does not save tweet if called multiple times" do
			count = Submission.count
			subject
			subject
			expect(Submission.count).to eq(count + 1)
		end
	end
end