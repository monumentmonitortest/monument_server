require 'rails_helper'
RSpec.describe Admin::CsvController, :type => :request do
  describe "#basic_submission" do

  end
  
  describe "#type_specific" do
    # # todo - ask someone why the fuck this dosn't work
    # let(:params) {{ "type_name"=>"INSTAGRAM" }}
    # before :each do
    #   get '/admin/type_specific_report', format: :csv
    # end

    # it "returns a report of submissions for the given type" do
    #   report = JSON.parse(response.body)
    #   expect(report).to eq []
    # end
  end

  describe "#site_specific" do

  end

  describe "#site_specific_tags" do
  end

  describe "#tags_report" do

  end

  describe "#image_quality" do

  end
end