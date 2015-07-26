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

ActiveRecord::Schema.define(version: 20150726190547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "unit_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "unit_id"
    t.boolean  "is_owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "unit_users", ["unit_id"], name: "index_unit_users_on_unit_id", using: :btree
  add_index "unit_users", ["user_id"], name: "index_unit_users_on_user_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.integer  "number"
    t.integer  "floor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "units", ["number"], name: "index_units_on_number", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.boolean  "is_admin",               default: false
    t.boolean  "is_board",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "unit_users", "units"
  add_foreign_key "unit_users", "users"
end
