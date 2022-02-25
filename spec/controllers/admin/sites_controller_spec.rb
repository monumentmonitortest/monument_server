require 'rails_helper'
RSpec.describe Admin::SitesController, type: :request do
  include Devise::Test::IntegrationHelpers
  
  before do
    user = User.create!(email: "thing@thing.com", password: "supersecure", admin: true)
    sign_in user
  end

  context 'GET /admin/sitess' do
    it 'returns a 200' do
      response = get admin_sites_path, params: {}
      expect(response).to eq(200)
    end
  end

  context 'creating a site' do
    let(:site_group) { create(:site_group) }
    let(:params) {{  
      "name": "Old Stone",
      "site_group_id": site_group.id, 
    }}

    context "with correct params" do
      it "create new site" do
        expect {
          post admin_sites_path, params: { site: params }
        }.to change(Site, :count)
      end
    end

    context "with incorrect params" do
      it "does not create site" do
        expect {
          post admin_sites_path, params: { site: {} }
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  context 'editing a site' do
    let!(:site) { create(:site, name: 'Loch Ness') }
    let(:sg_params) {{
      id: site.id,
      name: "Loch Doon",
      identifier: "Lake",
    }}
    
    context "with correct params" do
      it "updates site" do
        patch admin_site_path(site), params: { site: sg_params }
        expect(site.reload.name).to eq("Loch Doon")
      end
    end

    context "with incorrect params" do
      let(:sg_params) {{ }}
      it "does not update" do
        expect {
          patch admin_site_path(site), params: sg_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  context 'deleting a site' do
    let!(:site) { create(:site, name: 'Loch Ness') }
    
    context "with no submissions" do
      it "deletes site" do
        expect {
          delete admin_site_path(site)
        }.to change(Site, :count)
      end
    end

    context "with associated submissions submissions" do
      let!(:submissions) { create(:submission, site_id: site.id)}
      it "does not delete site" do
        expect {
          delete admin_site_path(site)
        }.to_not change(Site, :count)
      end
    end
  end
end
