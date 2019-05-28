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
    submissions = []
    params[:file].each do |key, image|
      registration_params = bulk_upload_permitted_params.merge(image: image)
      @registration = Registration.new(registration_params)
      if @registration.save
        submissions << "Image number #{key.to_i + 1}, upload sucessful"
      else
        submissions << "Image number #{key.to_i + 1}, upload unsucessful: #{@registration.errors.messages}"
      end
    end
    respond_to do |format|
      format.json{ render json: submissions }
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
    params.permit(:site_id,
                  :reliable, 
                  :record_taken, 
                  :type_name, 
                  :email_address, 
                  :number, 
                  :insta_username, 
                  :twitter_username)
  end

end
