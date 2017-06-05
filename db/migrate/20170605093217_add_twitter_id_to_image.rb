class AddTwitterIdToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :twitter_id, :bigint
  end
end
