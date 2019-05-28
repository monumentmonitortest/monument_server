class BulkUploadController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def index
  end
  
  def create
    submissions = []
    params[:file].each do |key, image|
      registration_params = permitted_params.merge(image: image)
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
end