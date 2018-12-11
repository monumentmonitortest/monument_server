class AddSite < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string   :name
      t.float    :latitude
      t.float    :longitude
      t.string   :pic_id
      t.integer  :visits
      t.integer  :visitors
      t.jsonb    :notes

      t.timestamps
    end
  end
end
