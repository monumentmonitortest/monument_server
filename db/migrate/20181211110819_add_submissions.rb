class AddSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.integer :site_id
      t.integer :type_id
      t.attachment :image
      t.boolean :reliable, :default => false
      t.datetime :record_taken
      t.jsonb :tags

      t.timestamps
    end
  end
end
