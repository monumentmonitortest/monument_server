
require "rails_helper"
Sidekiq::Testing.fake!

RSpec.describe Admin::ReportUploadController, type: :request do
  
  before do
    user = User.create!(email: "thing@thing.com", password: "supersecure", admin: true)
    sign_in user
  end
  
  let(:text_csv_path) { 'spec/fixtures/assets/basic.csv' }
  let(:params) { { 
    "date": Date.today - 1.week,
    "file": Rack::Test::UploadedFile.new(text_csv_path, 'text/csv', true) 
    } }
              
  describe "#index" do
    it "loads page" do
      response =  get "/admin/report_upload"
      expect(response).to eq 200
    end
  end

  describe "#create" do
    Sidekiq::Testing.inline! do
      context "with valid csv file" do
        subject { post "/admin/report_upload", params: params }
        
        it "calls upload job" do
          expect {
            subject
          }.to change(CsvReportUploadWorker.jobs, :size).by 1
        end
      end
    end

    context "without csv file" do
      let(:params) { {fake_params:  Rack::Test::UploadedFile.new(text_csv_path, 'text/csv', true)} }
      it "does not call job" do
        expect {
          subject
        }.to change(CsvReportUploadWorker.jobs, :size).by 0
      end
    end
  end
end