class Registration
  include ActiveModel::Model

  attr_accessor :reliable, :site_id, :image, :record_taken, :type_name, :email_address, :number, :insta_username, :twitter_username

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      submission = Submission.create!(site_id: site_id, reliable: reliable, record_taken: record_taken, image: image)
      submission.create_type!(name: type_name, 
                        email_address: email_address, 
                        number: number, 
                        insta_username: insta_username, 
                        twitter_username: twitter_username)
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)
    false
  end



end