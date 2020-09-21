require 'rails_helper'
# No longer used
RSpec.describe Admin::TypesController, type: :controller do
  # TODO - delete this when removing types from the sytem
  xcontext 'GET types' do
    let!(:email_submission) { create(:submission, type_name: "EMAIL") }
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
