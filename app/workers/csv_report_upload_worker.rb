require 'open-uri'

class CsvReportUploadJWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  
  def initialize(csv_file, date)
    @table = CSV.parse(File.read(csv_file), headers: true)
    @date = date.to_date

  end

  def perform
    @table.each do |sub|
      create_submission(sub) 
    end
  end

  private

  def create_submission(sub)
    id = sub['id']
    site_name = sub["site-name"]
    record_taken = sub['record-taken'].to_date
    record_submitted = sub['record_submitted'].to_date
    type_name = sub['type-name']    
    comment = sub['comment']
    metadata = sub['metadata']
    tag_list = sub['tag_list']
    image_url = ENV['BASE_URL'] + sub['image_url']

    if record_taken > @date
      unless Submission.find_by(id: id)
        registration = Registration.new(reliable: false, 
          site_id: site_id(site_name), 
          image_file: image_url, 
          comment: comment,
          record_taken: record_taken, 
          submitted_at: record_submitted,
          type_name: type_name, 
          participant_id: ENV['DEFAULT_PARTICIPANT']
        )
        
        if registration.save
          puts 'saved successffully'
        else
          # binding.pry
          puts "there was an error: #{registration.errors}"
        end
      else
        puts "submission already exists"
      end

    end
  end

  def site_id(site_name)
    Site.find_by(name: site_name).id
  end


end
