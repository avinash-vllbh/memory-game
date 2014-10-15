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

ActiveRecord::Schema.define(version: 20141015051352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "cards", force: true do |t|
    t.string   "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["content"], name: "index_cards_on_content", unique: true, using: :btree

  create_table "games", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "board",                   null: false
    t.integer  "total_pairs",             null: false
    t.text     "flipped"
    t.integer  "pairs_found", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
