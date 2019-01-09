class CreateSubmissionService  < ActiveInteraction::Base
# TODO - Specs for this

  integer :site_id
  # integer :type_id
  # string  :type_name
  date_time :record_taken
  boolean :reliable
  # image...

  hash :type_attributes do
    string :name
    # interface :data

  end

  def execute
    submission = create_submission
    type = create_type(submission)
  end

  private

  def create_type(submission)
    type ||= Type.new(name: type_attributes[:name], submission_id: submission.id).save
  end
    
    def create_submission
      Submission.create(
        site_id: site_id,
        record_taken: record_taken,
        reliable: reliable,
      )
  end
end