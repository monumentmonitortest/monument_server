class SubmissionZipWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(directory_suffix, site_id, email_address, type="", tags="")
    local_tmp_directory = tmp_directory(directory_suffix)
    s3_directory = s3_directory(directory_suffix)

    # Create zip and store in tmp folder
    ImageZipCreationService.new(local_tmp_directory, site_id, type, tags).create
    # Upload to S3
    s3Url = upload_to_s3(local_tmp_directory, s3_directory)
    # Send email
    ZipMailer.job_done(email: email_address, url: s3Url).deliver_now
  end

  private

  def tmp_directory(directory_suffix)
    "tmp/archive/" + directory_suffix + "_submissions" 
  end

  def s3_directory(directory_suffix)
    "archive/" + directory_suffix + '_submissions'
  end

  def upload_to_s3(tmp_directory, s3_directory)
    puts 'uploading to S3! (hopefully)'
    begin
      s3 = Aws::S3::Resource.new(region:'eu-west-2')
      if Rails.env == 'production'
        obj = s3.bucket(ENV['S3_BUCKET_PRODUCTION']).object(s3_directory)
      else
        obj = s3.bucket(ENV['S3_BUCKET_DEVELOPMENT']).object(s3_directory)
      end
      obj.upload_file("#{tmp_directory}.zip")
      obj.public_url
    rescue Aws::S3::Errors::ServiceError
      puts 'BUGGER'
    end
  end
end
