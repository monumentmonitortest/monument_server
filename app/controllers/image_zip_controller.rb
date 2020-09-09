require 'zip'
class ImageZipController < ApplicationController
  TMP_ARCHIVE_FOLDER_BASE = "tmp/archive_submissions".freeze
  
  def zip_images
    delete_current_tempfile # does this work on AWS?
    SubmissionZipWorker.perform_async(site_id, email_address, tmp_archive_dir)
    redirect_back(fallback_location: results_path, notice: 'Job started, images will be emailed when finished')
  end

  def download_zip
    obj = get_directory
    unless obj.exists?
      redirect_back(fallback_location: results_path, alert: "Zip folder not present, you need to create it using 'zip create and download'")
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
    "#{TMP_ARCHIVE_FOLDER_BASE}_#{site_id}"
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
    if Dir.exists?(tmp_archive_dir)
      FileUtils.rm_rf(Dir["#{tmp_archive_dir}/*"]) 
      FileUtils.rm_rf(Dir["#{tmp_archive_dir}"]) 
    end
  end
end
