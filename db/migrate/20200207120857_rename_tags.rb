class RenameTags < ActiveRecord::Migration[5.2]
  def change
    rename_column :submissions, :tags, :ai_tags
  end
end
