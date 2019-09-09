require 'uri'

class Registration
  include ActiveModel::Model

  attr_accessor :reliable, :site_id, :image, :image_file, :record_taken, :type_name, :email_address, :number, :insta_username, :twitter_username, :type_specific_id, :comment

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      submission = Submission.create!(site_id: site_id, reliable: reliable, record_taken: record_taken, image: image)

      save_image(submission, image_file) if image_file.present?

      submission.create_type!(name: type_name, 
                        email_address: email_address, 
                        number: number, 
                        insta_username: insta_username, 
                        twitter_username: twitter_username,
                        type_specific_id: type_specific_id,
                        comment: comment)
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)
    false
  end

  private

    def save_image(submission, image_file)
      begin
        file = URI.open(image_file)
        submission.image.attach(io: file, filename: 'animage.jpg')
      rescue OpenURI::HTTPError => e
        puts "image is buggered"
        errors.add(:base, e.message)
        false
      end
    end
end