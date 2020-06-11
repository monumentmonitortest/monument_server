require 'rails_helper'
Sidekiq::Testing.fake!

RSpec.describe Api::V1::ImageZipController, :type => :request do
  let(:site) { create(:site) }
  let(:params) { {site_id: site.id} }

  describe "GET #get_images" do

    context "without authentication" do
      before {get '/api/v1/zip_images'}
      it "returns http success" do
        # expect(response).to have_http_status(401)
        # expect(response.body).to include("Bad Credentials")
      end
    end

    context "with authentication" do
      headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }

      before {get '/api/v1/zip_images', params: params, headers: headers, as: :json}

      it "returns http success" do
        expect(response).to have_http_status(:redirect)
      end
    end
  end
  


  describe "GET #download_zip" do

    context "without authentication" do
      before {get '/api/v1/download_zip'}
      it "returns http success" do
        # expect(response).to have_http_status(401)
        # expect(response.body).to include("Bad Credentials")
      end
    end

    context "with authentication" do
      headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }

      before do
        get '/api/v1/download_zip', headers: headers, as: :json
      end

      it "downloads file" do
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq "application/zip"
      end
    end
  end
end