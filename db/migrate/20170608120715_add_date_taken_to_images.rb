class AddDateTakenToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :date_taken, :bigint
    add_column :images, :insta_user_id, :integer
  end
end
