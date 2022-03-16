class BasicSubmissionReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(email_address)
    @report = BasicSubmissionReportJob.new.perform

    @local_tmp_directory = "tmp/basic_submissions.csv"
    @azure_directory = "archive/basic_submissions.csv"

   
    azureUrl = upload_to_azure(@local_tmp_directory, @azure_directory)
    ZipMailer.job_done(email: email_address, url: azureUrl).deliver_now
  end

  private

  def upload_to_azure(tmp_directory, azure_directory)
    puts 'uploading to Azure! (hopefully)'
   
    begin
      client = Azure::Storage::Blob::BlobService.create(storage_account_name: ENV['STORAGE_ACCOUNT_NAME'], storage_access_key:ENV['STORAGE_ACCESS_KEY'])
      # if Rails.env == 'production'
      #   obj = client.get_blob(ENV['STORAGE_CONTAINER'], azure_directory)
      # else
      #   # update this with devlopment storage container
      #   obj = client.get_blob(ENV['STORAGE_CONTAINER'], azure_directory)
      # end
    
      content = ::File.open(tmp_directory, 'rb') { |file| file.read }
      client.create_block_blob(ENV['STORAGE_CONTAINER'], azure_directory, content)
      url = "https://" + ENV['STORAGE_ACCOUNT_NAME'] + ".blob.core.windows.net/" + ENV['STORAGE_CONTAINER'] + "/#{azure_directory}"
    rescue Azure::Core::Http::HTTPError #may need to be a different one
      puts 'BUGGER'
    end
  end  
end
