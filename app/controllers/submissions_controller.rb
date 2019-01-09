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
    outcome = CreateSubmissionService.run(submission_params.to_h)

    if outcome.valid?
      redirect_to site_path(outcome.site_id)
    else
      render 'new'
    end
  end

  private
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:reliable, 
                                       :site_id,
                                       :type_id,
                                       :type_name, 
                                       :image, 
                                       :record_taken, 
                                       :tags, 
                                       type_attributes: [:name, :data])
  end
  
end