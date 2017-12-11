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

ActiveRecord::Schema.define(version: 20171204132546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crimes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crimes_offenders", id: :serial, force: :cascade do |t|
    t.integer "crime_id"
    t.integer "offender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crime_id"], name: "index_crimes_offenders_on_crime_id"
    t.index ["offender_id"], name: "index_crimes_offenders_on_offender_id"
  end

  create_table "districts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measure_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measure_types_units", id: :serial, force: :cascade do |t|
    t.integer "measure_type_id"
    t.integer "unit_id"
    t.index ["measure_type_id"], name: "index_measure_types_units_on_measure_type_id"
    t.index ["unit_id"], name: "index_measure_types_units_on_unit_id"
  end

  create_table "measures", id: :serial, force: :cascade do |t|
    t.date "start_date_measure"
    t.date "end_date_measure"
    t.string "measure_type"
    t.integer "measure_deadline"
    t.string "measure_situation"
    t.string "ammount_end_days"
    t.integer "offender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "measure_id"
    t.integer "current_period"
    t.date "current_period_date"
    t.index ["offender_id"], name: "index_measures_on_offender_id"
  end

  create_table "offenders", id: :serial, force: :cascade do |t|
    t.string "id_citizen"
    t.string "name"
    t.date "birth_date"
    t.integer "age"
    t.string "recurrent"
    t.string "origin_county"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "crime_id"
    t.boolean "duplicated", default: false
    t.integer "unit_id"
    t.boolean "evaded", default: false
    t.date "evasion_date"
    t.boolean "has_photo"
    t.boolean "has_biometry"
    t.string "street"
    t.string "address_county"
    t.string "secondary_street"
    t.string "secondary_district"
    t.string "secondary_address_county"
    t.float "latitude"
    t.float "longitude"
    t.integer "district_id"
    t.index ["unit_id"], name: "index_offenders_on_unit_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "activities", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "simulations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "data"
    t.text "div_text"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_simulations_on_user_id"
  end

  create_table "unit_occupations", id: :serial, force: :cascade do |t|
    t.integer "unit_id"
    t.date "day"
    t.integer "occupation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_unit_occupations_on_unit_id"
  end

  create_table "units", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.integer "occupied"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_age", default: 12
    t.integer "max_age", default: 22
    t.string "street"
    t.string "district"
    t.string "county"
    t.float "latitude"
    t.float "longitude"
    t.string "photo"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "ctigi_auth_uid"
    t.string "ctigi_auth_access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "measures", "offenders"
  add_foreign_key "unit_occupations", "units"
end
