require 'rails_helper'
RSpec.describe Admin::DropUploadController, type: :request do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess
  include Devise::Test::IntegrationHelpers

  describe "drop uploading submissions" do
    before do
      user = User.create!(email: "thing@thing.com", password: "supersecure", admin: true)
      sign_in user
      group = SiteGroup.create!(name: ENV['UNSORTED_SITE_NAME'])
      Site.create!(name: ENV['UNSORTED_SITE_NAME'], site_group_id: group.id)
    end
    
    let(:headers)  { {"CONTENT_TYPE" => "application/json" }}
    let!(:test_image_path) { 'spec/fixtures/assets/test-image-with-exif.jpeg' }
    let(:params) {
      { "file": Rack::Test::UploadedFile.new(test_image_path, 'image/jpg', true) }
    }
    context "with correct file type" do
      it "creates a submission" do
        expect {
          post "/admin/drop_upload", params, headers: headers
        }.to change(Submission, :count)
      end
  
      it "allocates the submission to unknown site" do
        post "/admin/drop_upload", params, headers: headers
        expect(Submission.last.site_name).to eq(ENV['UNSORTED_SITE_NAME'])
      end
  
      it "correctly assigns submitted_at date" do
        post "/admin/drop_upload", params, headers: headers
        submission = Submission.last
        expect(submission.submitted_at).to eq(Date.today)
      end

      context "with date exif data" do
        it "assigns date from exif data" do
          post "/admin/drop_upload", params, headers: headers
          submission = Submission.last

          date = EXIFR::JPEG.new(test_image_path).date_time
          expect(submission.record_taken).to eq(date)
        end
      end

      
      context "without date exif data" do
        let(:test_image_path) { 'spec/fixtures/assets/test-image.jpg' }
        it "assigns todays date" do
          post "/admin/drop_upload", params, headers: headers
          submission = Submission.last

          expect(submission.record_taken).to eq(Date.today)
          expect(submission.submitted_at).to eq(Date.today)
        end
      end
    end
  
    context "incorrect file type" do
      let(:test_image_path) { 'spec/fixtures/assets/bad-test-image.png' }
      it "returns error message" do
        expect {
          post "/admin/drop_upload", params, headers: headers
        }.to_not change(Submission, :count)
      end
    end 

  end
end