require 'rails_helper'
RSpec.describe Admin::TypesController, type: :controller do
  context 'GET types' do
    let!(:email_submission) { create(:submission_with_type) }
    let!(:insta_submission) { create(:submission_with_insta_type) }
    let(:params) { {} }
    login_user

    it 'gets all the types' do
      get :index, params: params
      expect(response.status).to eq(200)

      expect(assigns(:types)).to include(email_submission.type)
      expect(assigns(:types)).to include(insta_submission.type)
    end
  end
end
