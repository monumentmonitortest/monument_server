class MakeReliableDefaultFalse < ActiveRecord::Migration[5.1]
  def change
    change_column :images, :reliable, :boolean, :default => false
  end
end
