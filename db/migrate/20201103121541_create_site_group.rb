class CreateSiteGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :site_groups do |t|
      t.string  :name
      t.integer :identifier
    end
  end
end
