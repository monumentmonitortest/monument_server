class RemoveTypeIdFromSubmission < ActiveRecord::Migration[5.2]
  def change
    remove_column :submissions, :type_id
  end
end
