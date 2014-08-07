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

ActiveRecord::Schema.define(version: 20140801231621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keys", force: true do |t|
    t.string   "key",          null: false
    t.integer  "keyable_id"
    t.string   "keyable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "laps", force: true do |t|
    t.integer  "lap_nr",          null: false
    t.integer  "race_session_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.float    "x",          null: false
    t.float    "y",          null: false
    t.float    "z",          null: false
    t.float    "rpm",        null: false
    t.float    "speed",      null: false
    t.float    "steer_rot",  null: false
    t.integer  "gear",       null: false
    t.boolean  "on_gas",     null: false
    t.boolean  "on_brake",   null: false
    t.boolean  "on_clutch",  null: false
    t.integer  "lap_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "race_sessions", force: true do |t|
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string   "ac_version", null: false
    t.string   "ot_version", null: false
    t.string   "user_agent", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.boolean  "admin",                  default: false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
