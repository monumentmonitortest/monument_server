require 'rails_helper'
RSpec.describe Submission, type: :model do
  
  context 'associations' do
    it { should belong_to(:site) }
    it { should have_one(:type) }
  end 
  
  context 'validations' do
    subject { described_class.new(correct_params) }
    let(:participant)     { create(:participant) }
    let(:participant_id)  { participant.id }
    let(:site)            { create(:site) }
    let(:site_id)         { site.id }
    let(:record_taken)    { Date.today }
    let(:image_url)       { Rack::Test::UploadedFile.new('./spec/fixtures/assets/test-image.jpg', 'image/png')}
    
    let(:correct_params) {{ site_id: site_id, 
                            participant_id: participant_id, 
                            record_taken: record_taken,
                            image: image_url }
                          }
    
    context 'when site is invalid' do
      let(:site_id) { 24 }
      it 'throws error' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages[:site_id].to_sentence).to eq "site id is invalid"
      end
    end
    
    context 'when participant is invalid' do
      let(:participant_id)    { 24 }
      
      it 'throws error' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages[:participant_id].to_sentence).to eq "participant is invalid or missing"
      end
    end

    context "when image url is nil" do
      let(:image_url) { nil }

      it "throws an error" do
        expect(subject.valid?).to be false
        expect(subject.errors.messages[:image].to_sentence).to eq "can't be blank"
      end
    end

    context 'when all params valid' do
      it 'creates submission' do
        expect(subject.valid?).to be true
      end
    end
  end

  context "set file name" do
    let(:submission) { create(:submission) }

    before { submission.set_filename}
    it "corrects the file name" do
      type = submission.type_name
      expected_filename = "#{submission.id}_#{Date.today.strftime("%d-%m-%Y")}_#{type.first.downcase}.jpg"

      expect(submission.image.attachment.filename.to_s).to eq expected_filename
    end
  end


  context "scope" do
    let!(:submission_one) { create(:submission, reliable: true) }
    let!(:submission_two) { create(:submission) }
   
    it "should scope on reliable" do
      expect(Submission.all.reliable.count).to eq 1
      expect(Submission.all.reliable).to include submission_one
    end
    
    context "#tags" do
    before do 
      tag_list = ['tag one', 'tag two']
      submission_one.tag_list = tag_list
      submission_one.save
    end

      it "filters on multiple tags" do
        expect(Submission.all.with_tags("tag one, tag two")).to eq [submission_one]
      end
    end
  end

  context "instance methods" do
    subject { create(:submission) }
    describe "#site_name" do
      it "returns site name" do
        expect(subject.site_name).to eq subject.site.name
      end 
    end
  end
end
