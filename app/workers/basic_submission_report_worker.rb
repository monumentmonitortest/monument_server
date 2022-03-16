class BasicSubmissionReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(email_address)
    @report = BasicSubmissionReportJob.new.perform

    @local_tmp_directory = "tmp/basic_submissions"
    @s3_directory = "archive/basic_submissions.csv"

   
    s3Url = upload_to_s3(@local_tmp_directory, @s3_directory)
    ZipMailer.job_done(email: email_address, url: s3Url).deliver_now
  end

  private

  def tmp_directory(directory_suffix)
    
  end

  def s3_directory(directory_suffix)
    "archive/basic_submissions"
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
      obj.upload_file("#{tmp_directory}.csv")
      obj.public_url
    rescue Aws::S3::Errors::ServiceError
      puts 'BUGGER'
    end
  end  
end
