class SubmissionZipWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(directory_suffix, site_id, email_address, type="", tags="")
    local_tmp_directory = tmp_directory(directory_suffix)
    azure_directory = azure_directory(directory_suffix)

    # Create zip and store in tmp folder
    ImageZipCreationService.new(local_tmp_directory, site_id, type, tags).create
    # Upload to azure
    azureUrl = upload_to_azure(local_tmp_directory, azure_directory)
    # Send email
    ZipMailer.job_done(email: email_address, url: azureUrl).deliver_now
  end

  private

  def tmp_directory(directory_suffix)
    "tmp/archive/" + directory_suffix + "_submissions" 
  end

  def azure_directory(directory_suffix)
    "archive/" + directory_suffix + '_submissions'
  end

  def upload_to_azure(tmp_directory, azure_directory)
    puts 'uploading to Azure! (hopefully)'
    begin
      client = Azure::Storage::Blob::BlobService.create(storage_account_name: ENV['STORAGE_ACCOUNT_NAME'], storage_access_key:ENV['STORAGE_ACCESS_KEY'])
      content = ::File.open("#{tmp_directory}.zip", 'rb') { |file| file.read }
      url = client.create_block_blob(ENV['STORAGE_CONTAINER'],  "#{azure_directory}.zip", content)
      url = "https://" + ENV['STORAGE_ACCOUNT_NAME'] + ".blob.core.windows.net/" + ENV['STORAGE_CONTAINER'] +  "/#{azure_directory}.zip"
    rescue Azure::Core::Http::HTTPError #may need to be a different one
      puts 'BUGGER'
    end
  end
end
