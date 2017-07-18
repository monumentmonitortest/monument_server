class RemoveDateTaken < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :date_taken
  end
end
