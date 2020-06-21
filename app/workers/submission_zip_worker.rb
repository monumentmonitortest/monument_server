class SubmissionZipWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(site_id, zip_directory)
    # Create zip and store in tmp folder
    ImageZipCreationService.new(site_id, zip_directory).create
    # Upload to S3
    s3Url = upload_to_s3(zip_directory, site_id)
    # Send email
    ZipMailer.job_done.(email: ENV["DESIGNATED_EMAIL"], url: s3Url).deliver_now
  end

  private

  def upload_to_s3(zip_path, site_id)
    puts 'uploading to S3! (hopefully)'
    begin
      s3 = Aws::S3::Resource.new(region:'eu-west-2')
      if Rails.env == 'production'
        obj = s3.bucket(ENV['S3_BUCKET_PRODUCTION']).object("archive_submissions_#{site_id}")
      else
        obj = s3.bucket(ENV['S3_BUCKET_DEVELOPMENT']).object("archive_submissions_#{site_id}")
      end
      obj.upload_file("#{zip_path}.zip")
      obj.public_url
    rescue Aws::S3::Errors::ServiceError
      puts 'BUGGER'
    end
  end
end
