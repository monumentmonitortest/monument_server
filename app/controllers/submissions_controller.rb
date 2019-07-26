class SubmissionsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  def index
    submissions_scope = Submission.all
        
    submissions_scope = submissions_scope.reliable if params[:reliable] == "1"
    submissions_scope = search_site(submissions_scope, params[:site_filter]) if params[:site_filter].present?
    submissions_scope = type_search(submissions_scope, params[:type_filter]) if params[:type_filter].present?
   
    @submissions = smart_listing_create(:submissions, submissions_scope, partial: "submissions/list")
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

  def search_site(collection, name)
    collection.where(site_id: Site.find_by(name: name))
  end
  
  def type_search(collection, type_name)
    type_name.upcase!
    collection = collection.joins(:type).where(types: { name: type_name})
    collection
  end

end
