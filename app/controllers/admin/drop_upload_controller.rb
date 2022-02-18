require 'exifr/jpeg'

class Admin::DropUploadController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :redirect_unless_admin

  TYPE_NAME = 'EMAIL'.freeze

  def index
  end

  def create
    if params[:file].present?
      results = bulk_upload_images
      respond_to do |format|
        format.html { redirect_to admin_submissions_url }
        format.json { render json: results }
      end
    else
      flash[:notice] = 'Make sure you include some pictures!'
      redirect_back(fallback_location: admin_bulk_upload_index_path)
    end
  end

  private

  def bulk_upload_images
    registration_params = {
      type_name: TYPE_NAME, 
      site_id: unsorted_site_id, 
      submitted_at: Date.today,
      participant_id: ENV['DEFAULT_PARTICIPANT'] || 'default@example.com',
      image: permitted_params[:file],
      record_taken: get_record_taken(permitted_params[:file].tempfile)
    }
    binding.pry
    @registration = Registration.new(registration_params)
    
    if @registration.save
      message = "Image upload sucessful"
    else
      message = "Image upload unsucessful: #{@registration.errors.messages}"
    end
    message
  end
  
  def get_record_taken(file)
    exif = EXIFR::JPEG.new(file)
    unless exif.date_time.present?
      date_taken = Date.today
    else
      date_taken = exif.date_time
    end
    date_taken
  end
  
  def permitted_params
    params.permit(:file)
  end

  def unsorted_site_id
    Site.find_by(name: ENV['UNSORTED_SITE_NAME']).id
  end
end