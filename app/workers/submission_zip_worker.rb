class SubmissionZipWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(site_id, zip_directory)
    # zip_directory = "#{archive_directory_base}_#{site_id}"

    ImageZipCreationService.new(site_id, zip_directory).create
    # SendEmail
    s3Url = upload_to_s3(zip_directory, site_id)
    # binding.pry
    puts s3Url
  end

  private

  def upload_to_s3(zip_path, site_id)
    puts 'uploading to S3! (hopefully)'
    begin
      s3 = Aws::S3::Resource.new(region:'eu-west-2')
      obj = s3.bucket(ENV['S3_BUCKET_DEVELOPMENT']).object("archive_submissions_#{site_id}")
      # binding.pry
      obj.upload_file("#{zip_path}.zip")
      obj.public_url
    rescue Aws::S3::Errors::ServiceError
      puts 'BUGGER'
    end
  end

  def send_email(url)

  end
end
