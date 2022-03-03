require 'rails_helper'
RSpec.describe FilterHomeController, :type => :request do
  let!(:submission) { create(:submission) }
  let(:params) { {} }
  
  describe "GET #index" do
    headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }

    context "without authentication" do
      before {get '/'}
      xit "returns http success" do
        expect(response).to have_http_status(401)
        expect(response.body).to include("Bad Credentials")
      end
    end

    context "with authentication" do
      before {get '/', params: params, headers: headers}

      it "returns http success" do
        expect(response).to have_http_status(:success)
        
        results = response.body
        expect(response.status).to eq 200
      end

      context "with site params" do
        let(:params) { {site_id: submission.site.id} }
        it "returns site name" do
          results = response.body
          expect(response.body).to include(submission.site_name)
        end
      end
    end
  end  
end