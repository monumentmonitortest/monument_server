require 'open-uri'

class CsvReportUploadJob
  include Rails.application.routes.url_helpers
  
  def initialize(data_row, date)
    @data_row = data_row
    @date = date.to_date
  end


  def create_submission
    id = @data_row[0].to_i #id
    site_id = find_site_id # site name
    record_taken = @data_row['record-taken'].to_date # record taken
    record_submitted = @data_row['record_submitted'].to_date # submitted at
    type_name = @data_row['type-name']    # type name
    comment = @data_row["comment"] # comment
    metadata = @data_row["metadata"] # metadata
    tag_list = @data_row["tag_list"] #tag_list
    image_url = get_image_url #image url
    
    if record_taken > @date
      unless Submission.find_by(id: id)
        registration = Registration.new(
          submission_id: id,
          reliable: false, 
          site_id: site_id, 
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
          puts "there was an error: #{registration.errors}"
        end
      else
        puts "submission already exists"
      end
    end
  end


  private
  

  def find_site_id
    site = Site.find_by(name: @data_row["site-name"])
    if site
      site.id
    else
      raise "the site does not exist"
    end
  end

  def get_image_url
    if Rails.env == 'production' || 'development'
      ENV['BASE_URL'] + @data_row['image_url'] 
    else
      root_url + @data_row['image_url'] 
    end
  end
end
