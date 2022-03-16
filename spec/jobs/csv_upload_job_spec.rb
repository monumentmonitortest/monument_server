require 'rails_helper'

RSpec.describe CsvReportUploadJob, type: :job do
  describe "perform" do
    data = CSV.parse(File.read('spec/fixtures/assets/basic.csv'), headers: true)
    
    let!(:site)      { create(:site, name: "Machrie Moor Standing Circles") }
    let(:data_row)  { data[0] }
    let(:date)      { (Date.today - 100.years).to_s }
    subject         { described_class.new(data_row, date) }

    context "where site name exists" do
      it "creates a new submission" do
        expect { subject.create_submission }.to change(Submission, :count).by 1
      end
    end

    # context "where site name does not exists" do
    #   let(:data_row) { data[1] }
    #   it "does not create a submission" do
    #     expect { subject.create_submission }.to raise_error(RuntimeError)
    #   end
    # end

    # context "where submission alread exists" do
    #   before { create(:submission, id: data[0][0])}
    #   it "creates a new submission" do
    #     expect { subject.create_submission }.not_to change(Submission, :count)
    #   end
    # end
  end
end
