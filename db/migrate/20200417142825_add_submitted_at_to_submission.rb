class AddSubmittedAtToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :submitted_at, :datetime
  end
end
