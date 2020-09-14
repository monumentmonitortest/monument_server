require 'uri'

class Registration
  include ActiveModel::Model

  attr_accessor :reliable, :site_id, :image, :image_file, :record_taken, :submitted_at, :type_name, :email_address, :number, :insta_username, :twitter_username, :type_specific_id, :comment

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      submission = Submission.create!(site_id: site_id, reliable: reliable, record_taken: record_taken, submitted_at: submitted_at, image: image)
      
      # For twitter and insta uploads, using image URL
      save_image(submission, image_file, type_name) if image_file.present?

      submission.create_type!(name: type_name, 
                              email_address: email_address, 
                              number: number, 
                              insta_username: insta_username, 
                              twitter_username: twitter_username,
                              type_specific_id: type_specific_id,
                              comment: comment)

      submission.set_filename unless image_file.present? 
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)
    false
  end

  private

  def save_image(submission, image_file, type_name)
    image_name = "#{submission.record_taken.strftime("%d/%m/%Y")}_#{type_name.first.downcase}.jpg"
    begin
      file = URI.open(image_file)
      submission.image.attach(io: file, filename: image_name)
    rescue OpenURI::HTTPError => e
      puts "image is buggered"
      errors.add(:base, e.message)
      false
    end
  end
    
end