require 'rails_helper'
RSpec.describe "BulkUpload", type: :request do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess
  
  describe "bulk uploading submissions" do
    
    context "with correct params" do
      let(:site) { create(:site) }
      it "create new submissions" do
        headers = { "CONTENT_TYPE" => "application/json" }
        test_image_path = 'spec/support/assets/test-image.jpg'
        params = {  
                    "site_id": site.id,
                    "reliable": "false", 
                    "record_taken": "1111-11-11",
                    "type_name": "INSTAGRAM", 
                    "email_address": "", 
                    "number": "", 
                    "insta_username": "123", 
                    "twitter_username": "",
                    "file": { "0": Rack::Test::UploadedFile.new(test_image_path, 'image/jpg', true) } 
                  }
        
        expect {
          post "/bulk_upload", params, headers: headers
        }.to change(Submission, :count)
      end
    end
      
      
      
    context "with image but incorrect params" do
      it "does not create submissions" do
        headers = { "CONTENT_TYPE" => "application/json" }
        test_image_path = 'spec/support/assets/test-image.jpg'
        params = { "file": { "0": Rack::Test::UploadedFile.new(test_image_path, 'image/jpg', true) } }
        
        expect {
          post "/bulk_upload", params, headers: headers
        }.to_not change(Submission, :count)
      end
    end

    context "without uploading image" do
      it "does not create submissions" do
        params = {}
        headers = { "CONTENT_TYPE" => "application/json" }

        expect {
          post "/bulk_upload", params: params, headers: headers
        }.to_not change(Submission, :count)
        
        # TODO - why does this not work?
        # follow_redirect!
        # expect(response.body).to include("include some pictures!")
      end
    end 
  end
end