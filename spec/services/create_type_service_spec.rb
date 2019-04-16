require 'rails_helper'

RSpec.describe CreateTypeService do
  let(:submission) { create(:submission) }
  let(:name) { "EMAIL" }
  let(:data) {{ email_address: "foo@thing.com" }}
  let(:valid_params) {{ name: name, data: data, submission_id: submission.id }}
  subject { described_class.run(valid_params) }


  context "with valid parameters" do
    context "when email type" do
      let(:name) { "EMAIL" }
      
      context "and email not present" do
        let!(:data) { {} }
        it "returns false" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:data][0]).to include("email_not_present")
        end
      end

      context "and email present" do
        it "creates type" do
          expect{ subject }.to change{ Type.count }.by(1)
          expect(subject.valid?).to be true
        end
      end
    end

    context "when instagram type" do
      let(:name) { "INSTAGRAM" }

      context "and insta_username not present" do
        let!(:data) { {} }
        
        it "returns false" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:data][0]).to include("insta_username_not_present")
        end
      end
      
      context "and insta_username present" do
        let!(:data) {{ insta_username: "harry123" }}

        it "creates type" do
          expect{ subject }.to change{ Type.count }.by(1)
          expect(subject.valid?).to be true
        end
      end

    end

    context "when whatsapp type" do
      let(:name) { "WHATSAPP" }

      context "and number not present" do
        it "returns error" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:data][0]).to include("whatsapp_number_not_present")
        end
      end
      context "and number present" do
        let!(:data) {{ wa_number: "123" }}
        it "creates type" do
          expect{ subject }.to change{ Type.count }.by(1)
          expect(subject.valid?).to be true
        end
      end
    end

    context "when twitter type" do
      let(:name) { "TWITTER" }

      context "and handle not present" do
        it "returns error" do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[:data][0]).to include("twitter_handle_not_present")
        end
      end
      context "and handle present" do
        let!(:data) {{ twitter_handle: "@harry934" }}
        it "creates type" do
          expect{ subject }.to change{ Type.count }.by(1)
          expect(subject.valid?).to be true
        end
      end
    end

    context "scrambling data" do
      let(:second_submission) { create(:submission) }
      let(:first_params) {{ name: name, data: data, submission_id: submission.id }}
      let(:second_params) {{ name: name, data: data, submission_id: second_submission.id }}
      let!(:first_entry) { described_class.run(first_params) }
      let!(:second_entry) { described_class.run(second_params) }

      it "should scramble two data entries in the same manner" do
        first = Type.all[0].data[:email_address]
        second = Type.all[1].data[:email_address]
        expect(first).to eq second
      end
    end
  end
end