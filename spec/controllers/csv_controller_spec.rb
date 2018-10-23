require "rails_helper"
RSpec.describe CsvController do
  
  context "#results" do
    render_views
    let!(:machrie) { create(:image, site: "MACHRIE", reliable: true) }
    let!(:holyrood) { create(:image, site: "HOLYROOD") }
    
    let(:params) { {} }
    before do
      post :results,  { params: params, format: :csv }
    end

    it "returns a 200" do
      expect(response.status).to eq(200)
    end
    
    it "returns a CSV file" do
      expect(response.content_type).to eq "text/csv"
    end

    it "contains all image information in csv file" do
      csv = response.body
      expect(csv). to include(machrie.site)
      expect(csv). to include(holyrood.site)
      expect(csv.split("\n").size).to eq(3)
    end

    context "when filters are used" do
      let(:params) { { filter: "MACHRIE" } }

      it "CSV file only contains filtered images" do
        csv = response.body
        expect(csv). to_not include(holyrood.site)
        expect(csv.split("\n").size).to eq(2)
      end
    end

    context "when reliable is selected" do
      let(:params) { { reliable_filter: "0" } }

      it "CSV returns only reliable images" do
        csv = response.body
        expect(csv). to_not include(holyrood.site)
        expect(csv.split("\n").size).to eq(2)
      end
    end
  end
end