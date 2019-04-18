class CreateTypeService  < ActiveInteraction::Base
  
  integer :submission_id
  string :name
  string :email_address
  string :insta_username
  string :twitter_username
  string :number

  def execute
    validate_params
    type = create_type
  end

  private

  def create_type#(submission)
    type ||= Type.new(
      name:             name,
      email_address:    email_address,
      insta_username:   insta_username,
      twitter_username: twitter_username,
      number:           number,
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
    errors.add(:email_not_present, "Email not present") unless email_address.present? 
  end

  def validate_instagram
    errors.add(:insta_username_not_present, "Instagram user not present") unless insta_username.present? 
  end

  def validate_twitter
    errors.add(:twitter_handle_not_present, "Twitter handle not present") unless twitter_username.present? 
  end

  def validate_whatsapp
    errors.add(:whatsapp_number_not_present, "Whatsapp number not present") unless number.present? 
  end
end
