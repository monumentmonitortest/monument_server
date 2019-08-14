class Type < ApplicationRecord
  belongs_to :submission
  store_accessor :data, :email_address, :number, :insta_username, :twitter_username
  validate :validate_name, :validate_params, on: :create

  before_create :annonymize_present_data

  NAMES = %w(INSTAGRAM EMAIL TWITTER WHATSAPP OTHER )
  DATA_TYPES = %W(email_address number insta_username twitter_username)

  def legible_type_data
    data.map {|a, b| b unless b.empty?}.compact.first
  end

  private

  def annonymize_present_data
    self.data.map do |k, v|
      if DATA_TYPES.include?(k)
        annonymised_value = v.empty? ? v : encrypt(v)
        self.data[k] =  annonymised_value
      end
    end
  end

  def encrypt(data)
    Digest::SHA1.hexdigest data
  end  

  def validate_name
    errors.add(:name, "Invalid type name") unless NAMES.include?(name)
  end

  def validate_params
    validate_email if name == "EMAIL" 
    validate_instagram if name == "INSTAGRAM" 
    validate_whatsapp if name == "WHATSAPP" 
    validate_twitter if name == "TWITTER" 
  end

  def validate_email
    errors.add(:type, "Email not present") unless email_address.present? 
  end

  def validate_instagram
    errors.add(:type, "Instagram user not present") unless insta_username.present? 
  end

  def validate_twitter
    errors.add(:type, "Twitter handle not present") unless twitter_username.present? 
  end

  def validate_whatsapp
    errors.add(:type, "Whatsapp number not present") unless number.present? 
  end
end

