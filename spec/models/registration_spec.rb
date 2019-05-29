require 'rails_helper'
RSpec.describe Registration, type: :model do
  let(:klass) { described_class.new(params) }

  let(:site) { create(:site) }
  let(:email) { "email@thing.com" }

  let(:params) { {
    reliable: true,
    site_id: site.id,
    record_taken: Date.today,
    type_name: "EMAIL",
    email_address: email,
    number: "",
    insta_username: "",
    twitter_username: "",
  }}

  describe "#save" do
    subject { klass.save }
    context "with correct parameters" do
      it "created submission and type" do
        expect(subject).to be true
      end
    end

    context "with incorrect params" do
      let(:email) { "" }
      it "does not create submission or type" do
        expect(subject).to be false
      end
    end
  end
end