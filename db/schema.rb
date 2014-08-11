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

ActiveRecord::Schema.define(version: 20140727224657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", primary_key: "country_id", force: true do |t|
    t.string   "code_2",     limit: 2, null: false
    t.string   "code_3",     limit: 3, null: false
    t.integer  "code_num",             null: false
    t.string   "name",                 null: false
    t.string   "code_4",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code_alias"
    t.string   "name_alias"
  end

  add_index "countries", ["code_2"], name: "index_countries_on_code_2", unique: true, using: :btree
  add_index "countries", ["code_3"], name: "index_countries_on_code_3", unique: true, using: :btree
  add_index "countries", ["code_4"], name: "index_countries_on_code_4", unique: true, using: :btree
  add_index "countries", ["code_alias"], name: "index_countries_on_code_alias", using: :btree
  add_index "countries", ["code_num"], name: "index_countries_on_code_num", unique: true, using: :btree
  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree
  add_index "countries", ["name_alias"], name: "index_countries_on_name_alias", using: :btree

  create_table "player_imports", force: true do |t|
    t.string   "player_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "gender"
    t.string   "alt_last_name_1"
    t.string   "alt_last_name_2"
    t.date     "dob"
    t.string   "hand"
    t.string   "backhand"
    t.text     "msgs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "p_code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "alt_last_name_1"
    t.string   "alt_last_name_2"
    t.date     "dob"
    t.string   "hand"
    t.string   "backhand"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  add_index "players", ["country_id"], name: "index_players_on_country_id", using: :btree
  add_index "players", ["p_code"], name: "index_players_on_p_code", unique: true, using: :btree

  create_table "rankings", force: true do |t|
    t.date     "r_date"
    t.string   "gender"
    t.integer  "rank"
    t.string   "player_name"
    t.string   "p_code"
    t.string   "nationality"
    t.string   "c_code"
    t.integer  "rank_points"
    t.string   "player_url"
    t.string   "player_msgs"
    t.string   "country_msgs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rankings", ["player_name"], name: "index_rankings_on_player_name", using: :btree
  add_index "rankings", ["r_date", "rank", "gender"], name: "index_rankings_on_r_date_and_rank_and_gender", unique: true, using: :btree

end
