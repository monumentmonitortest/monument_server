require 'aws-sdk-s3'

class ImageZipCreationService
  attr_accessor :tmp_dir, :site_id, :type, :tags

  def initialize(tmp_dir, site_id, type="", tags="")
    @tmp_dir = tmp_dir
    @site_id = site_id
    @type = type
    @tags = tags
  end

  def create
    # submissions = Site.find(@site_id).submissions
    submissions = Submission.with_attached_image.search_site(site_id).type_search(type).with_tags(tags)

    # Determine the length of the folder
    directory_length_same_as_documents = Dir["#{tmp_dir}/*"].length == submissions.length
    
    # Create a tmp folder if not exists
    FileUtils.mkdir_p(tmp_dir) unless Dir.exists?(tmp_dir)
    # Download and save documents to our tmp folder
    submissions.each do |submission|
      document = submission.image.attachment
      name = document.blob.filename.to_s
      year = submission.record_taken.strftime("%Y/")
      month = submission.record_taken.strftime("%m/")
      day = submission.record_taken.strftime("%d-")

      filename = day + name
      new_filename = year + month + filename
      # filename = document.blob.filename.to_s

      # User should be able to download files if not yet removed from tmp folder
      # if the folder is already there, we'd get an error
      create_tmp_folder_and_store_documents(document, tmp_dir, filename) unless directory_length_same_as_documents
      #---------- Convert to .zip --------------------------------------- #
      create_zip_from_tmp_folder(tmp_dir, filename, new_filename) unless directory_length_same_as_documents
    end
    
    zip_path = "#{@zip_path}.zip"
  end

  private

  def create_tmp_folder_and_store_documents(document, tmp_dir, filename)
    file = File.open(File.join(tmp_dir, filename), 'wb') do |file|
      begin
      document.download { |chunk| file.write(chunk) }
      rescue Aws::S3::Errors::ServiceError
        puts 'BUGGER'
      end
    end
  end

  def create_zip_from_tmp_folder(tmp_dir, filename, new_filename)
    # MAX_FILE_SIZE = 20 * 1024**2 # 10MiB
    # MAX_FILES = 200
    Zip::File.open("#{tmp_dir}.zip", Zip::File::CREATE) do |zf|
      begin
        zf.add(new_filename, "#{tmp_dir}/#{filename}")
        # raise 'Too many extracted files' if num_files > MAX_FILES #TODO: implement file size maximums!
        # raise 'File too large when extracted' if entry.size > MAX_FILE_SIZE
      rescue Zip::EntryExistsError
        puts "already exists, moving on..."
      end
    end
  end
end

