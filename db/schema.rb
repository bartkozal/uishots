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

ActiveRecord::Schema.define(version: 20151108075559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pins", ["shot_id"], name: "index_pins_on_shot_id", using: :btree
  add_index "pins", ["user_id"], name: "index_pins_on_user_id", using: :btree

  create_table "shots", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "tmp_image"
  end

  add_index "shots", ["user_id"], name: "index_shots_on_user_id", using: :btree

  create_table "taggables", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "shot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggables", ["shot_id"], name: "index_taggables_on_shot_id", using: :btree
  add_index "taggables", ["tag_id"], name: "index_taggables_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "guest",                        default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  add_foreign_key "pins", "shots"
  add_foreign_key "pins", "users"
  add_foreign_key "shots", "users"
  add_foreign_key "taggables", "shots"
  add_foreign_key "taggables", "tags"
end
