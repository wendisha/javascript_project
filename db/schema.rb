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

ActiveRecord::Schema.define(version: 2019_04_26_192036) do

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.string "country_of_origin"
    t.integer "user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "nation"
    t.string "league_division"
    t.integer "user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "length"
    t.integer "weekly_salary"
    t.integer "transfer_fee"
    t.text "unusual_clauses"
    t.string "status"
    t.integer "futbolista_id"
    t.integer "club_id"
    t.integer "agent_id"
    t.integer "user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "country_of_origin"
    t.string "position"
    t.integer "agent_id"
    t.integer "club_id"
    t.integer "contract_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
  end

end
