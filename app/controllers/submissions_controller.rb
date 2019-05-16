class SubmissionsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  skip_before_action :verify_authenticity_token, :only => [:js_bulk_upload]
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
    @presenter = ::Registrations::BasePresenter.new(@submission, view_context)
  end


  def js_bulk_upload
    # TODO - individual params for each of these!
    params[:file].each do |key, image|
      Submission.create(site_id: params[:site_id], image: image)
    end
    respond_to do |format|
      format.json{ render json: { ok: 'ok' } }
    end
  end
  
  def create
  end

  def destroy
    @submission.destroy
  end
  
  private
  
  def set_submission
    @submission = Submission.find(params[:id])
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

  def bulk_upload_permitted_params
    params.require(:submission).permit(:site_id, :image)

  end

end
