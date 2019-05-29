require 'rails_helper'
RSpec.describe TypesController, :type => :request do
  context 'GET types' do
    let!(:email_submission) { create(:submission_with_type) }
    let!(:insta_submission) { create(:submission_with_insta_type) }
    let(:params) { {} }

    it 'gets all the types' do
      get "/types"
      expect(response.status).to eq(200)
      expect(response.body).to include(email_submission.type.name)
      expect(response.body).to include(insta_submission.type.name)
    end

    # TODO - implement filter?
    context 'without filter' do
    end
  end
end
