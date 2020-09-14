class AddTypeInfoToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :type_name, :string
    add_column :submissions, :comment, :text
    add_column :submissions, :type_specific_id, :string
    add_column :submissions, :participant_id, :integer
  end
end
