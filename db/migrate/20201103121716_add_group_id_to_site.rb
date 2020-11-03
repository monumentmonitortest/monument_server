class AddGroupIdToSite < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :site_group_id, :integer
  end
end
