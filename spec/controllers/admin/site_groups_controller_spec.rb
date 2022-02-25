require 'rails_helper'
RSpec.describe Admin::SiteGroupsController, type: :request do
  include Devise::Test::IntegrationHelpers
  
  before do
    user = User.create!(email: "thing@thing.com", password: "supersecure", admin: true)
    sign_in user
  end

  context 'GET /admin/sites_groups' do
    it 'returns a 200' do
      response = get admin_site_groups_path, params: {}
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
          post admin_site_groups_path, params: { site_group: params }
        }.to change(SiteGroup, :count)
      end
    end

    context "with incorrect params" do
      it "does not create site group" do
        expect {
          post admin_site_groups_path, params: { site_group: {} }
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
    
    context "with correct params" do
      it "updates site group" do
        patch admin_site_group_path(site_group), params: { site_group: sg_params }
        expect(site_group.reload.name).to eq("Loch Doon")
      end
    end

    context "with incorrect params" do
      let(:sg_params) {{ }}
      it "does not update" do
        expect {
          patch admin_site_group_path(site_group), params: sg_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  context 'deleting a site group' do
    let!(:site_group) { create(:site_group, name: 'Loch Ness') }
    let(:sg_params) {{
      id: site_group.id
    }}
    
    context "with correct params" do
      it "deletes site group" do
        expect {
          delete admin_site_group_path(site_group), params: sg_params
        }.to change(SiteGroup, :count)
      end
    end
  end
end
