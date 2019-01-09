class Type < ApplicationRecord
  belongs_to :submission

  NAMES = %w(INSTAGRAM EMAIL TWITTER WHATSAPP OTHER )

end