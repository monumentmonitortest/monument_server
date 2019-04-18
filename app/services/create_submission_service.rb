class CreateSubmissionService  < ActiveInteraction::Base
# TODO - Specs for this

  integer :site_id
  date_time :record_taken
  boolean :reliable
  
  hash :type_attributes,
    strip: false

  def execute
    # this creates a submission, then uses that to create a type
    # BUT when a type can't be created, it shouldn't create a submission
    # AND when either of them error, it should tell me why.

    submission = create_submission
    type_attributes[:submission_id] = submission.id
    type = CreateTypeService.run(type_attributes)
    if type.invalid?
      submission.errors.messages[:type] = type.errors.messages
      binding.pry
      errors.add(:type_attributes, :type_not_created)
      errors.add(:type_attributes, type.errors.messages)
      return submission
    end

    submission.save
    submission
  end

  private

  def create_type_attributes
    type_data = type_attributes[:submission_id] = submission.id
  end
    
  def create_submission
    Submission.create(
      site_id: site_id,
      record_taken: record_taken,
      reliable: reliable,
    )
  end
end