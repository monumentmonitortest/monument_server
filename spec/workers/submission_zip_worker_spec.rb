require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SubmissionZipWorker, type: :worker do
  let(:site_id)        { '1' }
  let(:zip_path)    {  "tmp/achive_submission_#{site_id}"}
  let(:public_url)  { "www.image.zip" }
  let(:email)       { 'email@yay.com' }
  describe "#perform" do
    before do
      obj = double("S3 object", public_url: public_url, upload_file: true)
      aws = double("AWS", object: obj)
      
      allow_any_instance_of(Aws::S3::Resource)
        .to receive(:bucket)
        .and_return(aws)
    end

    context "when called" do
      it "creates an async job" do
        expect {
          described_class.perform_async(site_id, email, zip_path)
        }.to change(SubmissionZipWorker.jobs, :size).by(1)
      end

      it "calls image zip creation service" do
        service = double("service double")
        allow(ImageZipCreationService).to receive(:new).and_return(service)
        allow(service).to receive(:create)
        
        # TODO - deal with this email stuff..
        mailer = double("email")
        allow(mailer).to receive(:call).with(email: email, url: public_url).and_return(mailer)
        
        expect(service).to receive(:create)
        described_class.perform_async(site_id, email, zip_path)

        expect(ZipMailer).to receive(:job_done).and_return(mailer)
        expect(mailer).to receive(:deliver_now)

        Sidekiq::Worker.drain_all
      end

      context "uploading to s3" do
        subject { described_class.new.send(:upload_to_s3, zip_path, site_id)  }
            
        it "calls s3" do
          expect(subject).to eq public_url
        end
      end
    end
  end
end
