class BulkUploadController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :redirect_unless_admin

  def index
  end

  def create
    if params[:file].present?
      results = bulk_upload_images
      respond_to do |format|
        format.html { redirect_to submissions_url }
        format.json { render json: results }
      end
    else
      flash[:notice] = 'Make sure you include some pictures!'
      redirect_back(fallback_location: bulk_upload_index_path)
    end
  end

  private

  def permitted_params
    params.permit(:site_id,
                  :reliable, 
                  :record_taken, 
                  :type_name, 
                  :email_address, 
                  :number, 
                  :insta_username, 
                  :twitter_username)
  end

  # TODO - work out if this should be somewhere else?
  def bulk_upload_images
    submissions = []
    params[:file].each do |key, image|
      registration_params = permitted_params.merge(image: image)
      
      # binding.pry
      @registration = Registration.new(registration_params)

      if @registration.save
        submissions << "Image number #{key.to_i + 1}, upload sucessful"
      else
        submissions << "Image number #{key.to_i + 1}, upload unsucessful: #{@registration.errors.messages}"
      end
    end
    submissions
  end
end