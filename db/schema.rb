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

ActiveRecord::Schema.define(version: 20160305114727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "offenders", force: :cascade do |t|
    t.string   "id_citizen"
    t.string   "unit"
    t.string   "name"
    t.date     "birth_date"
    t.integer  "age"
    t.string   "recurrent"
    t.string   "origin_county"
    t.string   "article"
    t.string   "measure_type"
    t.integer  "measure_deadline"
    t.date     "start_date_measure"
    t.date     "end_date_measure"
    t.string   "measure_situation"
    t.string   "ammount_end_days"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
