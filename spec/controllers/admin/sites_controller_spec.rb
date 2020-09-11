require 'rails_helper'
RSpec.describe Admin::SitesController, type: :controller do
  include Devise::Test::ControllerHelpers

  context 'GET /admin/sites' do
    let!(:site) { create(:site, name: 'MACHRIE') }
    let(:params) { {} }

    login_user
    before do
      get :index, params: params
    end

    it 'returns a 200' do
      expect(response.status).to eq(200)
    end

    context 'without filter' do
      it 'returns all site' do
        expect(assigns(:sites)).to eq([site])
      end
    end
  end
end
