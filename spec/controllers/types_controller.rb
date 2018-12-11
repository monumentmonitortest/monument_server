require 'rails_helper'
RSpec.describe TypesController do
  context 'GET types' do
    let!(:types) { create(:types, name: 'Instagram') }
    let(:params) { {} }

    before do
      get :index, params: params
    end

    it 'returns a 200' do
      expect(response.status).to eq(200)
    end

    context 'without filter' do
      it 'returns all types' do
        expect(assigns(:typess)).to eq([types])
      end
    end
  end
end
