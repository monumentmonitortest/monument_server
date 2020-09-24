# frozen_string_literal: true

require 'rails_helper'
RSpec.describe SubmissionsDataCreateService do
  describe '#create' do
    let(:participant) { create(:participant, first_submission: Date.today)}
    let(:participant_two) { create(:participant, first_submission: Date.today - 1.month)}
    let!(:sub_one) { create(:submission, participant_id: participant.id) }
    let!(:sub_two) { create(:submission_with_insta_type, participant_id: participant_two.id, record_taken: Date.today - 1.month) }

    subject { described_class.new(Submission.all, Date.today - 1.year) }

    let(:expected_object) do
      { byMonth: [{ x: '09/19', y: 0 },
                  { x: '10/19', y: 0 },
                  { x: '11/19', y: 0 },
                  { x: '12/19', y: 0 },
                  { x: '01/20', y: 0 },
                  { x: '02/20', y: 0 },
                  { x: '03/20', y: 0 },
                  { x: '04/20', y: 0 },
                  { x: '05/20', y: 0 },
                  { x: '06/20', y: 0 },
                  { x: '07/20', y: 0 },
                  { x: '08/20', y: 1 },
                  { x: '09/20', y: 1 }],
        participantsByMonth: [{ x: '09/19', y: 0 },
                              { x: '10/19', y: 0 },
                              { x: '11/19', y: 0 },
                              { x: '12/19', y: 0 },
                              { x: '01/20', y: 0 },
                              { x: '02/20', y: 0 },
                              { x: '03/20', y: 0 },
                              { x: '04/20', y: 0 },
                              { x: '05/20', y: 0 },
                              { x: '06/20', y: 0 },
                              { x: '07/20', y: 0 },
                              { x: '08/20', y: 1 },
                              { x: '09/20', y: 1 }],
        totalParticipants: 2,
        ai_tags: [],
        types: [{ x: 'Email', y: 1 }, { x: 'Instagram', y: 1 }],
        maxSubs: ['Some Stones', 'Some Stones'],
        minSubs: ['Some Stones', 'Some Stones'] }
    end

    it 'creates this object' do
      expect(subject.create).to eq expected_object
    end
  end
end
