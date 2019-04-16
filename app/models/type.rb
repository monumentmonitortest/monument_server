class Type < ApplicationRecord
  belongs_to :submission
  # data is a shit name for a field btw.
  store_accessor :data, :email_address, :number, :insta_username, :twitter_username 
  
  before_create :annonymize_present_data

  NAMES = %w(INSTAGRAM EMAIL TWITTER WHATSAPP OTHER )
  DATA_TYPES = %W(email_address number insta_username twitter_username)

  private

  def annonymize_present_data
    self.data.map do |k, v|
      annonymised_value = v.empty? ? v : encrypt(v)
      self.data[k] =  annonymised_value
    end
  end

  def encrypt(data)
    Digest::SHA1.hexdigest data
  end  
end
