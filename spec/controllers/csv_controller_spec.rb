require "rails_helper"
RSpec.describe CsvController do
  
  context "#results" do
    render_views
    
    let(:site)            { create(:site) }
    let(:params)          { {site_id: site.id} }
    let(:service_double)  { double(:create_csv_service) }
    let(:result)          { "csv,file" }

    login_user
    before do
      allow(CSVCreateService).to receive(:new).and_return(service_double)
      allow(service_double).to receive(:create).and_return(result)
    end
    
    it "calls the CSV create service" do
      expect(service_double).to receive(:create)
      post :results,  { params: params, format: :csv }
      expect(response.body).to eq result
    end

    context "response" do
      before do
        post :results,  { params: params, format: :csv }
      end

      it "returns a 200" do
        expect(response.status).to eq(200)
      end
      
      it "returns a CSV file" do
        expect(response.content_type).to eq "text/csv"
      end
    end
  end
end