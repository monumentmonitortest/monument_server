require 'rails_helper'
RSpec.describe Type, type: :model do
  context 'associations' do
    it { should belong_to(:submission) }
  end 
  
  subject { described_class.create(params) }
  let(:submission) { create(:submission) }
  let(:name)              { "EMAIL" }
  let(:email_address)     { "" }
  let(:twitter_username)  { "" }
  let(:insta_username)    { "" }
  let(:number)            { "" }
  let(:params)            {{ 
                            submission_id: submission.id,
                            name: name, 
                            email_address: email_address, 
                            twitter_username: twitter_username, 
                            insta_username: insta_username, 
                            number: number 
                          }}


  context "validations" do
    context "when email type" do
      let(:name) { "EMAIL" }
      
      context "and email not present" do
        it "returns false" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:type].to_sentence).to eq "Email not present"
        end
      end

      context "and email present" do
        let!(:email_address) { "thingfoo.com" }
        it "creates type" do
          expect(subject.valid?).to be true
        end
      end
    end

    context "when instagram type" do
      let(:name) { "INSTAGRAM" }

      context "and insta_username not present" do
        
        it "returns false" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:type].to_sentence).to eq "Instagram user not present"
        end
      end
      
      context "and insta_username present" do
        let!(:insta_username) { "@thing" }

        it "creates type" do
          expect(subject.valid?).to be true
        end
      end

    end

    context "when whatsapp type" do
      let(:name) { "WHATSAPP" }

      context "and number not present" do
        it "returns error" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:type].to_sentence).to eq "Whatsapp number not present"
        end
      end
      context "and number present" do
        let!(:number) { "123" }
        it "creates type" do
          expect(subject.valid?).to be true
        end
      end
    end

    context "when twitter type" do
      let(:name) { "TWITTER" }

      context "and handle not present" do
        it "returns error" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:type].to_sentence).to eq "Twitter handle not present"
        end
      end
      context "and handle present" do
        let!(:twitter_username) { "@harry934" }
        it "creates type" do
          expect(subject.valid?).to be true
        end
      end
    end

    context "scrambling data" do
      let(:email_address)     { "thing@foo.com" }
      let(:second_submission) { create(:submission) }
      let(:second_params)     {{ 
                                submission_id: second_submission.id,
                                name: name, 
                                email_address: email_address, 
                                twitter_username: twitter_username, 
                                insta_username: insta_username, 
                                number: number 
                              }}
      
      it "should scramble two data entries in the same manner" do
        first = described_class.create(params)
        second = described_class.create(second_params)
        
        expect(first.email_address).to eq second.email_address
      end
    end
  end
end