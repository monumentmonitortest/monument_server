require "rails_helper"
RSpec.describe CsvController do
  
  xcontext "#create" do
    render_views
    
    
    login_user
    before do
    end
    
    # it "calls the CSV create service" do
    #   expect(service_double).to receive(:create)
    #   post :results,  { params: params, format: :csv }
    #   expect(response.body).to eq result
    # end

    # context "response" do
    #   before do
    #     post :results,  { params: params, format: :csv }
    #   end

    #   it "returns a 200" do
    #     expect(response.status).to eq(200)
    #   end
      
    #   it "returns a CSV file" do
    #     expect(response.content_type).to eq "text/csv"
    #   end
    end
  end
end