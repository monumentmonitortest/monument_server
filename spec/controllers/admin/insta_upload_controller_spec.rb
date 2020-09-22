require 'rails_helper'
RSpec.describe Admin::InstaUploadController, type: :request do
  let(:headers)  { {"CONTENT_TYPE" => "application/json" }}
  let(:instamancer) { 'spec/fixtures/assets/monumentmonitor.json' }
  let(:params) {{  
                  "CSV-file": { "0": Rack::Test::UploadedFile.new(instamancer, 'application/json') },
                  "from_date": Date.today - 1.week 
                }}
                
  xcontext "with correct params" do
    it "create new submissions" do
      expect {
        post "/admin/insta_upload", params: params, headers: headers
      }.to change(Submission, :count)

    end
  end
end