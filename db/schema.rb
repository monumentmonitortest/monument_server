# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190425161509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "insta_users", force: :cascade do |t|
    t.string "user_name"
    t.string "location"
    t.integer "followers_count"
    t.integer "friends_count"
    t.integer "post_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "pic_id"
    t.integer "visits"
    t.integer "visitors"
    t.jsonb "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "site_id"
    t.integer "type_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "reliable", default: false
    t.datetime "record_taken"
    t.jsonb "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "twitter_users", force: :cascade do |t|
    t.bigint "twitter_id"
    t.string "user_name"
    t.string "location"
    t.integer "followers_count"
    t.integer "friends_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.jsonb "data"
    t.integer "submission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
