require 'zip'
class ImageZipController < ApplicationController

  def zip_images
    delete_current_tempfile
    # TODO - ensure this is updated
    tmp_dir = "#{site_id}"
    SubmissionZipWorker.perform_async(tmp_dir, site_id, email_address)
    redirect_back(fallback_location: admin_results_path, notice: 'Job started, images will be emailed when finished')

    # TODO - remove tempfile (possibly...)
  end

  def download_zip
    obj = get_directory
    unless obj.exists?
      redirect_back(fallback_location: admin_results_path, alert: "Zip folder not present, you need to create it using 'zip create and download'")
    else
      redirect_to obj.public_url
      flash[:notice] = "Zip file downloading"
    end
  end
  private
  
  def site_id
    @site_id ||= permitted_params[:site_id]
  end

  def email_address
    permitted_params[:email].present? ? permitted_params[:email] : ENV["DESIGNATED_EMAIL"]
  end

  def tmp_archive_dir
    # returns tmp/archive_submissions_6 for site ID 6
    "#{site_id}"
  end

  def permitted_params
    params.permit(:site_id, :email)
  end

  def get_directory
    # TODO - dry up s3 calls
    begin
      s3 = Aws::S3::Resource.new(region:'eu-west-2')
      if Rails.env == 'production'
        obj = s3.bucket(ENV['S3_BUCKET_PRODUCTION']).object("archive/#{site_id}_submissions")
      else
        obj = s3.bucket(ENV['S3_BUCKET_DEVELOPMENT']).object("archive/#{site_id}_submissions")
      end
    rescue Aws::S3::Errors::ServiceError
      puts 'BUGGER'
    end
  end


  def delete_current_tempfile
    # delete both archive folder and contents
    if Dir.exists?("tmp/archive/#{site_id}")
      FileUtils.rm_rf(Dir["tmp/archive/#{site_id}/*"]) 
      FileUtils.rm_rf(Dir["tmp/archive/#{site_id}"]) 
    end
  end
end
