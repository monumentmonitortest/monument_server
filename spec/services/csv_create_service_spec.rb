require "rails_helper"
RSpec.describe CSVCreateService do
  let(:submission) { create(:submission_with_type) }
  let(:params) {{ site_id: submission.site_id }}
  let(:expected_csv) { "site_name,image_url,type_name,reliable,record_taken\nSome Stones,/images/original/missing.png,EMAIL,false,2019-04-26 00:00:00 UTC\n" }
  
  subject { described_class.new(params) }

  describe "#create" do
    subject { described_class.new(params).create }
    
    it "creates a csv" do
      expect(subject).to be_a(String)
    end

    it "includes submission details" do
      expect(subject).to include(submission.site.name)
      expect(subject).to include(submission.image.url)
      expect(subject).to include(submission.type.name)
      expect(subject).to include(submission.image.url)
      expect(subject).to include(submission.record_taken.to_s)
    end

    it "only includes headers and submission details" do
      expect(subject.result.split("\n").size).to eq(10)
    end
  end

  # TODO: Bad case
end