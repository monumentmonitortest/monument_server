class Participant < ApplicationRecord
  has_many :submissions

  validate :validate_params, on: :create
  before_create :annonymize_participant_id

  def validate_params
    errors.add(:type, "participant id not present") unless participant_id.present? 
  end

  def annonymize_participant_id
    self.participant_id = Digest::SHA1.hexdigest self.participant_id
  end  
end