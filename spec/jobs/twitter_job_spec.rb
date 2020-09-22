require 'rails_helper'

RSpec.describe TwitterJob, type: :job do
	describe "perform" do
		let!(:site)					 	{ create(:site, name: 'Twitter unsorted')}
		let(:twitter_handle) 	{ '@monumentmonitor' }
		let!(:participant) 		{ Participant.create(participant_id: twitter_handle) }

		before do
			user_object = double('user object', id: twitter_handle)
			media_object = double('tweet media object', id: 456, media_url: 'https://www.monumentmonitor.co.uk/static/media/ness.2adde48e.jpg')
			tweet_object = double('tweet object', media: [media_object], retweet?: false, text: 'tweet text', user: user_object, created_at: Date.today )
      twitter_client = double("client", search: [tweet_object])
      allow_any_instance_of(TwitterClient).to receive(:client).and_return(twitter_client)
		end
		
		subject { described_class.new.perform }
		
		it "saves tweet" do
			subject
			submission = Submission.last
			expect(submission.comment).to eq('tweet text') 
			expect(submission.record_taken).to eq(Date.today)
			expect(submission.participant).to eq(participant)
			expect(submission.type_specific_id).to eq("456")
		end

		it "does not save tweet if called multiple times" do
			count = Submission.count
			subject
			subject
			expect(Submission.count).to eq(count + 1)
		end
	end
end