require 'rails_helper'

RSpec.describe ScriptRegistration, type: :model do
  subject { described_class.new(params) }

  let(:site) { create(:site) }
  let(:email) { 'email@thing.com' }
  let(:image) { Rails.root.join('spec', 'fixtures', 'assets', 'test-image.jpg') }
  let(:date)  { Date.today }
  let(:params) do
    {
      reliable: true,
      site_id: site.id,
      record_taken: date,
      type_name: 'EMAIL',
      participant_id: email,
      image_file: image
    }
  end

  describe '#save' do
    context 'with correct parameters' do
      it 'created successfully saves' do
        expect(subject.save).to be true
      end

      it 'creates a new submission' do
        expect { subject.save }.to change { Submission.count}.by(1)
      end

      it 'creates a new participant' do
        expect { subject.save }.to change { Participant.count }.by(1)
      end

      it 'correctly assigned first_submission to participant' do
        subject.save
        expect(Participant.last.first_submission).to eq date
      end

      it 'correctly saves image filename' do
        subject.save
        submission = Submission.last
        # binding.pry
        expect(submission.image.attached?).to be true
        file_name = "#{submission.id}_#{submission.record_taken.strftime('%d-%m-%Y')}_e.jpg"
        expect(submission.image.attachment.filename.to_s).to eq file_name
      end
    end

    context 'with no participant' do
      let(:email) { '' }
      it "assigns a defualt participant" do
        id = Participant.new(participant_id: Participant::DEFAULT_EMAIL).annonymize_participant_id

        subject.save
        submission = Submission.last
        expect(submission.participant.participant_id).to eq id
      end
    end

    context 'with invalid file' do
      let(:image) { Rack::Test::UploadedFile.new('./spec/fixtures/assets/archive_submissions.zip', '.zip') }

      it 'does not create a submission' do
        expect {subject.save}.to change {Submission.count}.by(1)
      end
    end

    context 'with incorrect params' do
      let(:date) { '' }
      it 'does not create submission or type' do
        expect(subject.save).to be false
      end
    end
  end
end
