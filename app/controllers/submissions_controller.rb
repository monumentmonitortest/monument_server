class SubmissionsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @submissions = smart_listing_create(:submissions, Submission.all, partial: "submissions/listing")
  end

  def show
    @submission = Submission.find(params[:id])
  end

  private
  def submission_params
    params.require(:submission).permit(:reliable, :site_id, :type_id, :image, :record_taken, :tags)
  end
  
end