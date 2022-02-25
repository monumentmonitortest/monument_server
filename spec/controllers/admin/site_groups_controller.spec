require 'rails_helper'
RSpec.describe Admin::SiteGroupsController, type: :request do
  include Devise::Test::IntegrationHelpers
  
  before do
    user = User.create!(email: "thing@thing.com", password: "supersecure", admin: true)
    sign_in user
  end

  context 'GET /admin/sites_groups' do
    it 'returns a 200' do
      response = get "/admin/site_groups", params: {}
      expect(response).to eq(200)
    end
  end

  context 'creating a site group' do
    let(:params) {{  
      "name": "New Group",
      "identifier": "Building", 
    }}

    context "with correct params" do
      it "create new site group" do
        expect {
          post "/admin/site_groups", params: { site_group: params }
        }.to change(SiteGroup, :count)
      end
    end

    context "with incorrect params" do
      it "does not create site group" do
        expect {
          post "/admin/site_groups", params: { site_group: {} }
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  context 'editing a site group' do
    let!(:site_group) { create(:site_group, name: 'Loch Ness') }
    let(:sg_params) {{
      id: site_group.id,
      name: "Loch Doon",
      identifier: "Lake",
    }}
    let(:path) { "/admin/site_groups/#{site_group.id}" }
    
    context "with correct params" do
      it "updates site group" do
        patch path, params: { site_group: sg_params }
        expect(site_group.reload.name).to eq("Loch Doon")
      end
    end

    context "with incorrect params" do
      let(:sg_params) {{ }}
      it "does not update" do
        expect {
          patch "/admin/site_groups/#{site_group.id}", params: sg_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  context 'deleting a site group' do
    let!(:site_group) { create(:site_group, name: 'Loch Ness') }
    let(:sg_params) {{
      id: site_group.id
    }}
    let(:path) { "/admin/site_groups/#{site_group.id}" }
    
    context "with correct params" do
      it "deletes site group" do
        expect {
          delete "/admin/site_groups/#{site_group.id}", params: sg_params
        }.to change(SiteGroup, :count)
      end
    end
  end
end
