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

ActiveRecord::Schema.define(version: 20141109162628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", primary_key: "country_id", force: :cascade do |t|
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

  create_table "players", force: :cascade do |t|
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

  create_table "ranking_players", force: :cascade do |t|
    t.string   "player_name"
    t.string   "p_code"
    t.string   "nationality"
    t.string   "c_code"
    t.string   "player_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
  end

  add_index "ranking_players", ["gender", "player_name", "nationality"], name: "index_ranking_players_on_gender_and_player_name_and_nationality", unique: true, using: :btree

  create_table "rankings", force: :cascade do |t|
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
  add_index "rankings", ["r_date", "rank", "gender"], name: "index_rankings_on_r_date_and_rank_and_gender", using: :btree

  create_table "rpexc_ambig_cs", force: :cascade do |t|
    t.integer  "rpexception_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rpexc_ambig_cs", ["country_id"], name: "index_rpexc_ambig_cs_on_country_id", using: :btree
  add_index "rpexc_ambig_cs", ["rpexception_id"], name: "index_rpexc_ambig_cs_on_rpexception_id", using: :btree

  create_table "rpexc_ambig_pcodes", force: :cascade do |t|
    t.integer  "rpexception_id"
    t.string   "p_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rpexc_ambig_pcodes", ["rpexception_id"], name: "index_rpexc_ambig_pcodes_on_rpexception_id", using: :btree

  create_table "rpexc_ambig_ps", force: :cascade do |t|
    t.integer  "rpexception_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rpexc_ambig_ps", ["player_id"], name: "index_rpexc_ambig_ps_on_player_id", using: :btree
  add_index "rpexc_ambig_ps", ["rpexception_id"], name: "index_rpexc_ambig_ps_on_rpexception_id", using: :btree

  create_table "rpexc_dup_pcodes", force: :cascade do |t|
    t.integer  "rpexception_id"
    t.integer  "player_id"
    t.string   "p_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rpexc_dup_pcodes", ["player_id"], name: "index_rpexc_dup_pcodes_on_player_id", using: :btree
  add_index "rpexc_dup_pcodes", ["rpexception_id"], name: "index_rpexc_dup_pcodes_on_rpexception_id", using: :btree

  create_table "rpexception_types", force: :cascade do |t|
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "exc_code"
  end

  create_table "rpexceptions", force: :cascade do |t|
    t.boolean  "resolved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rpexception_type_id"
    t.integer  "ranking_player_id"
    t.integer  "player_id"
    t.integer  "country_id"
  end

  add_index "rpexceptions", ["country_id"], name: "index_rpexceptions_on_country_id", using: :btree
  add_index "rpexceptions", ["player_id"], name: "index_rpexceptions_on_player_id", using: :btree
  add_index "rpexceptions", ["ranking_player_id"], name: "index_rpexceptions_on_ranking_player_id", using: :btree
  add_index "rpexceptions", ["rpexception_type_id"], name: "index_rpexceptions_on_rpexception_type_id", using: :btree

  create_table "system_logs", force: :cascade do |t|
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
