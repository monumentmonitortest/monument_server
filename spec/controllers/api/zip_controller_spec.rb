require 'rails_helper'
RSpec.describe Api::V1::ZipController, :type => :request do
  describe '#zip_images' do
    let!(:submission) { create(:submission, type_name: "EMAIL") }
    let(:email) { 'foo@example.com' }
    let(:site_name) { submission.site.name }

    context "email params not present" do
      let(:params) {{ site_name: site_name }}
      before { get '/api/v1/zip_images', params: params }
      
      it "returns message" do
        expect(response.body).to include ("Ensure you are logged in, and have selected a site")
      end
    end

    context "site params not present" do
      let(:params) {{ email: email }}
      before { get '/api/v1/zip_images', params: params }
      
      it "returns message" do
        expect(response.body).to include ("Ensure you are logged in, and have selected a site")
      end
    end

  end
end