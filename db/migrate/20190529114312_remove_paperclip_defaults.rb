class RemovePaperclipDefaults < ActiveRecord::Migration[5.2]
  def change
    remove_attachment :submissions, :image
  end
end
