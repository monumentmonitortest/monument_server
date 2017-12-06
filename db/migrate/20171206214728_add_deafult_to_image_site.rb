class AddDeafultToImageSite < ActiveRecord::Migration[5.1]
  def change
    change_column :images, :site, :string, :default => "UNDEFINED"
  end
end
