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

ActiveRecord::Schema.define(version: 20150225020509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "boards", force: true do |t|
    t.integer "game_id"
    t.integer "card_id"
    t.integer "position"
    t.string  "state",    default: "origin", null: false
  end

  add_index "boards", ["game_id"], name: "index_boards_on_game_id", using: :btree

  create_table "cards", force: true do |t|
    t.string   "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["content"], name: "index_cards_on_content", unique: true, using: :btree

  create_table "games", force: true do |t|
    t.integer  "user_id"
    t.integer  "total_pairs"
    t.integer  "pairs_found", default: 0
    t.string   "difficulty",  default: "easy"
    t.string   "status",      default: "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grid_size",   default: 4
    t.integer  "guesses",     default: 0
    t.integer  "accuracy",    default: 0
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "guesses",                default: 0
    t.integer  "matches",                default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
