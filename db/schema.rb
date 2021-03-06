# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150823185329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "publish_date"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "announcements", ["user_id"], name: "index_announcements_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "user_id"
    t.integer  "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "s3_key"
    t.string   "s3_bucket"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.date     "date"
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "parking_spots", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "parking_spots", ["number"], name: "index_parking_spots_on_number", unique: true, using: :btree

  create_table "parking_spots_users", id: false, force: :cascade do |t|
    t.integer "parking_spot_id", null: false
    t.integer "user_id",         null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer  "number"
    t.integer  "floor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "units", ["number"], name: "index_units_on_number", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.integer  "role"
    t.string   "shared_email"
    t.string   "phone"
    t.boolean  "can_sms"
    t.string   "occupation"
    t.text     "bio"
    t.string   "gender"
    t.string   "facebook_url"
    t.integer  "unit_id"
    t.string   "twitter_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree
  add_index "users", ["unit_id"], name: "index_users_on_unit_id", using: :btree

  create_table "users_own_units", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "unit_id", null: false
  end

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "announcements", "users"
  add_foreign_key "documents", "users"
  add_foreign_key "users", "units"
end
