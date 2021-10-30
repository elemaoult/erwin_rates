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

ActiveRecord::Schema.define(version: 2021_10_30_004409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expertises", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "freelancer_expertises", force: :cascade do |t|
    t.bigint "expertise_id", null: false
    t.bigint "freelancer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expertise_id"], name: "index_freelancer_expertises_on_expertise_id"
    t.index ["freelancer_id"], name: "index_freelancer_expertises_on_freelancer_id"
  end

  create_table "freelancer_industries", force: :cascade do |t|
    t.bigint "industry_id", null: false
    t.bigint "freelancer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["freelancer_id"], name: "index_freelancer_industries_on_freelancer_id"
    t.index ["industry_id"], name: "index_freelancer_industries_on_industry_id"
  end

  create_table "freelancer_technologies", force: :cascade do |t|
    t.bigint "technology_id", null: false
    t.bigint "freelancer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["freelancer_id"], name: "index_freelancer_technologies_on_freelancer_id"
    t.index ["technology_id"], name: "index_freelancer_technologies_on_technology_id"
  end

  create_table "freelancers", force: :cascade do |t|
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
    t.bigint "source_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["source_id"], name: "index_freelancers_on_source_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sources", force: :cascade do |t|
    t.datetime "date"
    t.string "data_source"
    t.boolean "seed_valid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "freelancer_expertises", "expertises"
  add_foreign_key "freelancer_expertises", "freelancers"
  add_foreign_key "freelancer_industries", "freelancers"
  add_foreign_key "freelancer_industries", "industries"
  add_foreign_key "freelancer_technologies", "freelancers"
  add_foreign_key "freelancer_technologies", "technologies"
  add_foreign_key "freelancers", "sources"
end
