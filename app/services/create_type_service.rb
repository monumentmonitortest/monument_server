class CreateTypeService  < ActiveInteraction::Base
  
  integer :submission_id
  string :name

  
  hash :data,
    strip: false

  def execute
    validate_params
    type = create_type
  end

  private

  def create_type#(submission)
    type ||= Type.new(
      name:             name,
      email_address:    (data[:email_address] if data[:email_address]),
      insta_username:   (data[:insta_username] if data[:insta_username]),
      twitter_username: (data[:twitter_handle] if data[:twitter_handle]),
      number:           (data[:wa_number] if data[:wa_number]),
      submission_id:    submission_id
    ).save
  end
    
  def validate_params
    validate_email if name == "EMAIL" 
    validate_instagram if name == "INSTAGRAM" 
    validate_whatsapp if name == "WHATSAPP" 
    validate_twitter if name == "TWITTER" 
  end

  def validate_email
    errors.add(:data, :email_not_present) unless data[:email_address].present? 
  end

  def validate_instagram
    errors.add(:data, :insta_username_not_present) unless data[:insta_username].present? 
  end

  def validate_twitter
    errors.add(:data, :twitter_handle_not_present) unless data[:twitter_handle].present? 
  end

  def validate_whatsapp
    errors.add(:data, :whatsapp_number_not_present) unless data[:wa_number].present? 
  end
end
