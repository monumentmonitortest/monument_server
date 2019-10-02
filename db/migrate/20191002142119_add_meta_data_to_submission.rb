class AddMetaDataToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :metadata, :jsonb, null: false, default: {}
  end
end
