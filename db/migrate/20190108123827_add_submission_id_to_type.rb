class AddSubmissionIdToType < ActiveRecord::Migration[5.1]
  def change
    add_column :types, :submission_id, :integer
  end
end
