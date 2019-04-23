require 'rails_helper'
RSpec.describe Submission, type: :model do
  
  context 'associations' do
    it { should belong_to(:site) }
    it { should have_one(:type) }
  end 
  
  context 'validations' do
    subject { described_class.new(params) }
    let(:params) { { site_id: 123 }}
    
    context 'when site id invalid' do
      it 'throws error' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages[:site_id].to_sentence).to eq "site id is invalid"
      end
    end
    
    context 'when site id valid' do
      let(:site)   { create(:site) }
      let(:params) { { site_id: site.id }}

      it 'creates submission' do
        expect(subject.valid?).to be true
      end
    end
  end
end
