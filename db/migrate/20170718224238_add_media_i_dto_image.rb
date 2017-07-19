class AddMediaIDtoImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :media_id, :bigint
  end
end
