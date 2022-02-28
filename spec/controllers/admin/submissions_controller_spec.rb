require 'rails_helper'
RSpec.describe Admin::SubmissionsController, type: :request do
  include Devise::Test::IntegrationHelpers
  
  before do
    user = User.create!(email: "thing@thing.com", password: "supersecure", admin: true)
    sign_in user
  end

  context 'editing a submission' do
    let!(:submission) { create(:submission) }
    let(:date) { Date.today - 2.days }
    let(:sub_params)  {{"submission"=>{"site_id"=>submission.site_id, "record_taken"=>date, }, "id"=>submission.id}}
    # let(:sub_params)  {{date_taken: date}}

    context "with correct params" do
      it "updates submission" do
        headers = { "CONTENT_TYPE" => "application/json" }
        patch admin_submission_path(submission), :params => sub_params.to_json, :headers => headers
        expect(response.body).to include "Submission Updated"
      end
    end

    context "with incorrect params" do
      let(:sub_params) {{ }}
      it "does not update" do
        expect {
          patch admin_submission_path(submission), params: sub_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  context 'deleting a submission' do
    let!(:submission) { create(:submission) }
    
    context "with no submissions" do
      it "deletes submission" do
        expect {
          delete admin_submission_path(submission)
        }.to change(Submission, :count)
      end
    end
  end
end
