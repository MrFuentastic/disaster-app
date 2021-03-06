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

ActiveRecord::Schema.define(version: 20171112194610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emergencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emergency_relief_services", force: :cascade do |t|
    t.integer "emergency_id"
    t.integer "relief_service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emergency_safe_locations", force: :cascade do |t|
    t.integer "emergency_id"
    t.integer "safe_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "emergency_id"
    t.datetime "time_of_occurence"
    t.string "status"
    t.decimal "lat", precision: 6, scale: 4
    t.decimal "long", precision: 7, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_pic_file_name"
    t.string "event_pic_content_type"
    t.integer "event_pic_file_size"
    t.datetime "event_pic_updated_at"
  end

  create_table "relief_services", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "safe_locations", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.decimal "lat", precision: 6, scale: 4
    t.decimal "long", precision: 7, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sl_image_file_name"
    t.string "sl_image_content_type"
    t.integer "sl_image_file_size"
    t.datetime "sl_image_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.decimal "lat", precision: 6, scale: 4
    t.decimal "long", precision: 7, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
