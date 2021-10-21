# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_21_223520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expertises", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "origins", force: :cascade do |t|
    t.datetime "date"
    t.string "data_origin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.text "job_description"
    t.string "mission_duration_sought"
    t.string "experience"
    t.integer "nb_of_previous_mission"
    t.decimal "rating"
    t.boolean "remote"
    t.integer "daily_rate"
    t.string "currency"
    t.bigint "origin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["origin_id"], name: "index_people_on_origin_id"
  end

  create_table "person_expertises", force: :cascade do |t|
    t.bigint "expertise_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expertise_id"], name: "index_person_expertises_on_expertise_id"
    t.index ["person_id"], name: "index_person_expertises_on_person_id"
  end

  create_table "person_industries", force: :cascade do |t|
    t.bigint "industry_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["industry_id"], name: "index_person_industries_on_industry_id"
    t.index ["person_id"], name: "index_person_industries_on_person_id"
  end

  create_table "person_technologies", force: :cascade do |t|
    t.bigint "technology_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_person_technologies_on_person_id"
    t.index ["technology_id"], name: "index_person_technologies_on_technology_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "people", "origins"
  add_foreign_key "person_expertises", "expertises"
  add_foreign_key "person_expertises", "people"
  add_foreign_key "person_industries", "industries"
  add_foreign_key "person_industries", "people"
  add_foreign_key "person_technologies", "people"
  add_foreign_key "person_technologies", "technologies"
end
