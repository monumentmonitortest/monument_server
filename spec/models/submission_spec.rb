require 'rails_helper'
RSpec.describe Submission, type: :model do
  
  context 'associations' do
    it { should belong_to(:site) }
    it { should have_one(:type) }
  end 
  
  context 'validations' do
    subject { described_class.new(params) }
    let(:params) { { site_id: 123, record_taken: Date.today }}
    
    context 'when site id invalid' do
      it 'throws error' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages[:site_id].to_sentence).to eq "site id is invalid"
      end
    end
    
    context 'when site id valid' do
      let(:site)   { create(:site) }
      let(:params) { { site_id: site.id, record_taken: Date.today }}

      it 'creates submission' do
        expect(subject.valid?).to be true
      end
    end
  end

  context "scope" do
    let!(:submission_one) { create(:submission, reliable: true) }
    let!(:submission_two) { create(:submission) }
   
    it "should scope on reliable" do
      expect(Submission.all.reliable.count).to eq 1
      expect(Submission.all.reliable).to include submission_one
    end
  end

  context "instance methods" do
    subject { create(:submission_with_type) }
    describe "#site_name" do
    it "returns site name" do
      expect(subject.site_name).to eq subject.site.name
    end 
  end
  
    describe "#type_name" do
      it "returns type name" do
        expect(subject.type_name).to eq subject.type.name
      end   
    end
  end

end
