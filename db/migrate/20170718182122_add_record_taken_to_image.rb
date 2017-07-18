class AddRecordTakenToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :record_taken, :datetime
  end
end
