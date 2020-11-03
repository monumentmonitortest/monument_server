class AddGroupIdToSite < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :group_id, :integer
  end
end
