class DropImagesTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :images do |t|
      t.string :url
      t.string :site, default: "UNDEFINED"
      t.jsonb :watson_info
      t.jsonb :weather_info
      t.boolean :reliable, default: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :twitter_id
      t.bigint :twitter_user_id
      t.integer :insta_user_id
      t.string :source
      t.datetime :record_taken
      t.bigint :media_id
      t.string :category
      t.string :submission_file_name
      t.string :submission_content_type
      t.bigint :submission_file_size
      t.datetime :submission_updated_at
    end
  end
end
