class AddDefaultToSubmissionTags < ActiveRecord::Migration[5.2]
  def change
    change_column :submissions, :tags, :jsonb, :default => "{}"
  end
end
