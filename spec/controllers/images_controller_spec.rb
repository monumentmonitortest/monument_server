require "rails_helper"
RSpec.describe ImagesController do
  context " GET index" do
    let!(:machrie_image_insta)   { create(:image, site: "MACHRIE", source: "INSTA") }
    let!(:machrie_image_twitter) { create(:image, site: "MACHRIE", source: "TWITTER") }
    let!(:machrie_image_upload)  { create(:image, site: "MACHRIE", source: "UPLOAD") }
    
    let!(:holyrood_image_insta)  { create(:image, site: "HOLYROOD", source: "INSTA") }
    let!(:holyrood_image_twitter){ create(:image, site: "HOLYROOD", source: "TWITTER") }
    let!(:holyrood_image_upload) { create(:image, site: "HOLYROOD", source: "UPLOAD") }
    
    let(:all_images) do  
      [machrie_image_insta,
      machrie_image_twitter,
      machrie_image_upload,
      holyrood_image_insta,
      holyrood_image_twitter,
      holyrood_image_upload]
    end

    let(:params) {{}}

    before do
      get :index, params: params
    end

    it "returns a 200" do
      expect(response.status).to eq(200)
    end

    context "without filter" do
      it "returns all images" do
        expect(assigns(:images)).to eq(all_images)
      end
    end

    context "with filter on site" do
      let(:params) { { filter: "machrie" } }
      it "returns all images within that filter" do
        images = assigns(:images)

        expect(images.count).to eq 3
        expect(images).to include(machrie_image_insta, machrie_image_twitter, machrie_image_upload)
      end
    end

    context "with filter on source" do
      let(:params) { {filter: 'insta' }}
      it "returns all images within that filter" do
        images = assigns(:images)

        expect(images.count).to eq 2
        expect(images).to include(machrie_image_insta, holyrood_image_insta)
      end
    end

    context "with multiple filters" do
    end

    context "with 'reliable' selected" do
      let(:params) { { reliable?: '1'} }
      before { machrie_image_insta.update_attributes(reliable: true) }
      it "only returns reliable images" do
        images = assigns(:images)

        expect(images.count).to eq 1
        expect(images).to include(machrie_image_insta)
      end
    end
  end

  context "#csv" do

  end
end
