require 'rails_helper'
RSpec.describe Registration, type: :model do
  subject { described_class.new(params) }

  let(:site) { create(:site) }
  let(:email) { "email@thing.com" }
  let(:image) { fixture_file_upload('/assets/test-image.jpg', 'image/png') }
  let(:params) { {
    reliable: true,
    site_id: site.id,
    record_taken: Date.today,
    type_name: "EMAIL",
    email_address: email,
    number: "",
    insta_username: "",
    twitter_username: "",
    image: image
  }}

  describe "#save" do
    context "with correct parameters" do
      it "created successfully saves" do
        expect(subject.save).to be true
      end
      
      it "creates a new submission" do
        expect {subject.save}.to change{Submission.count}.by(1) 
      end
      
      it "creates a new type" do
        expect {subject.save}.to change{Type.count}.by(1) 
      end

      
      it 'correctly saves image filename' do
        subject.save
        submission = Submission.last
        expect(submission.image.attached?).to be true
        file_name = "#{submission.record_taken.strftime("%d-%m-%Y")}_e.jpg"
        expect(submission.image.attachment.filename.to_s).to eq file_name
      end
    end

    context "with invalid file" do
      let(:image) { fixture_file_upload('/assets/archive_submissions.zip', '.zip') }

      it "does not create a submission" do
        expect {subject.save}.to change{Submission.count}.by(1) 
      end
    end

    context "with incorrect params" do
      let(:email) { "" }
      it "does not create submission or type" do
        expect(subject.save).to be false
      end
    end
  end
end