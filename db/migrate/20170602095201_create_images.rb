class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :url
      t.string :site
      t.jsonb :watson_info
      t.jsonb :weather_info
      t.boolean :reliable

      t.timestamps
    end
  end
end
