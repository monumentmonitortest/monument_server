class SubmissionsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  def index
    @submissions = smart_listing_create(:submissions, Submission.all, partial: "submissions/list")
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def edit
  end

  def update
    @submission.update_attributes(submission_params)
  end

  def new
    @submission = Submission.new(site_id: params[:site_id])
    @submission.build_type
    @presenter = ::Submissions::BasePresenter.new(@submission, view_context)
  end

  def create
    # TODO - specs for this
    outcome = CreateSubmissionService.run(service_params)
    if outcome.valid?
      redirect_to site_path(outcome.site_id)
    else
      puts outcome.errors.messages
      redirect_to new_site_submission_path(outcome.site_id)
      flash[:error] = outcome.errors.messages
      # this way is not quite working because of daisy-chaining which is Bad.
    end
  end

  private
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def service_params
    type_attributes = type_params.to_h
    params = submission_params.to_h
    params[:type_attributes] = type_attributes
    params
  end

  def submission_params
    params.require(:submission).permit(:reliable, 
                                       :site_id,
                                       :type_id,
                                       :image, 
                                       :record_taken, 
                                       :tags 
    )
  end

  def type_params
    params.require(:submission).require(:type_attributes).permit(
                                                                  :name,
                                                                  :email_address,
                                                                  :number,
                                                                  :insta_username,
                                                                  :twitter_username
    )
  end
  
end