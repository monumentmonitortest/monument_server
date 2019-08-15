require "rails_helper"
RSpec.describe CsvController do
  
  context "#create" do
    render_views
    
    login_user
    before do
    end
    
    it "uploads a whole bunch of instagram posts" do
      # TODO - if this is how it will go
      # expect(service_double).to receive(:create)
      # post :results,  { params: params, format: :csv }
      # expect(response.body).to eq result
    end
  end
end