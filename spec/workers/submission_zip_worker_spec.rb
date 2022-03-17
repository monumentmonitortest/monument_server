require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SubmissionZipWorker, type: :worker do
  let(:suffix)      { '1' }
  let(:site_id)     { '1' }
  let(:zip_path)    {  "tmp/achive_submission_#{site_id}" }
  let(:public_url)  { "https://mmimagestest.blob.core.windows.net/imagestest/tmp/achive_submission_1.zip" }
  let(:email)       { 'email@yay.com' }
  describe "#perform" do
    before do
      azure = double("AZURE", present?: true)
          
      allow_any_instance_of(Azure::Storage::Blob::BlobService)
        .to receive(:create_block_blob)
        .and_return(azure)

      service = double("service double")
      allow(ImageZipCreationService).to receive(:new).and_return(service)
      allow(service).to receive(:create)
    end
    
    context "when called" do
      it "creates an async job" do
        expect {
          described_class.perform_async(suffix, site_id, email, zip_path)
        }.to change(SubmissionZipWorker.jobs, :size).by(1)
      end
      
      it "calls image zip creation service" do
        service = double("service double")
        allow(ImageZipCreationService).to receive(:new).and_return(service)
        allow(service).to receive(:create)
        
        # stub out upload to azure - tested in next text
        allow_any_instance_of(described_class).to receive(:upload_to_azure) { public_url }
        
        expect(service).to receive(:create)
        described_class.perform_async(suffix, site_id, email, zip_path)
        
        # TODO - deal with this email stuff..
        mailer = double("email")
        allow(mailer).to receive(:call).with(email: email, url: public_url).and_return(mailer)


        expect(ZipMailer).to receive(:job_done).and_return(mailer)
        expect(mailer).to receive(:deliver_now)

        Sidekiq::Worker.drain_all
      end

      context "uploading to azure" do
        let(:test_zip_path)      { 'spec/fixtures/assets/archive_submissions' }
        subject { described_class.new.send(:upload_to_azure, test_zip_path, zip_path)  }
            
        it "calls s3" do
          expect(subject).to eq public_url
        end
      end
    end
  end
end
