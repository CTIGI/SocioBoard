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

ActiveRecord::Schema.define(version: 20160418172038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crimes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crimes_offenders", force: :cascade do |t|
    t.integer  "crime_id"
    t.integer  "offender_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "crimes_offenders", ["crime_id"], name: "index_crimes_offenders_on_crime_id", using: :btree
  add_index "crimes_offenders", ["offender_id"], name: "index_crimes_offenders_on_offender_id", using: :btree

  create_table "measure_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measure_types_units", force: :cascade do |t|
    t.integer "measure_type_id"
    t.integer "unit_id"
  end

  add_index "measure_types_units", ["measure_type_id"], name: "index_measure_types_units_on_measure_type_id", using: :btree
  add_index "measure_types_units", ["unit_id"], name: "index_measure_types_units_on_unit_id", using: :btree

  create_table "measures", force: :cascade do |t|
    t.date     "start_date_measure"
    t.date     "end_date_measure"
    t.string   "measure_type"
    t.integer  "measure_deadline"
    t.string   "measure_situation"
    t.string   "ammount_end_days"
    t.integer  "offender_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "measure_id"
    t.integer  "current_period"
    t.date     "current_period_date"
  end

  add_index "measures", ["offender_id"], name: "index_measures_on_offender_id", using: :btree

  create_table "offenders", force: :cascade do |t|
    t.string   "id_citizen"
    t.string   "name"
    t.date     "birth_date"
    t.integer  "age"
    t.string   "recurrent"
    t.string   "origin_county"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "crime_id"
    t.boolean  "duplicated",    default: false
    t.integer  "unit_id"
  end

  add_index "offenders", ["unit_id"], name: "index_offenders_on_unit_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "activities", default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "simulations", force: :cascade do |t|
    t.string   "name"
    t.text     "data"
    t.text     "div_text"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "simulations", ["user_id"], name: "index_simulations_on_user_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "capacity"
    t.integer  "occupied"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "min_age",    default: 0
    t.integer  "max_age",    default: 150
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.integer  "ctigi_auth_uid"
    t.string   "ctigi_auth_access_token"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "measures", "offenders"
end
