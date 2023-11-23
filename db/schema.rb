# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_23_221642) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.string "award_name"
    t.datetime "deletion_date"
    t.boolean "deletion_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.integer "term"
    t.integer "time"
    t.date "first_evaluation_submission_date"
    t.date "second_evaluation_submission_date"
    t.date "award_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "department_name"
    t.datetime "deletion_date"
    t.boolean "deletion_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "effect_amounts", force: :cascade do |t|
    t.string "kaizen_type"
    t.string "unit"
    t.integer "amount"
    t.boolean "deletion_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluator_progresses", force: :cascade do |t|
    t.string "status"
    t.boolean "deletion_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluators", force: :cascade do |t|
    t.string "status"
    t.datetime "deletion_date"
    t.boolean "deletion_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tsk_values", force: :cascade do |t|
    t.string "value_name"
    t.datetime "deletion_date"
    t.boolean "deletion_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "employee_code"
    t.bigint "department_id"
    t.bigint "evaluator_id"
    t.integer "first_evaluator_id"
    t.integer "second_evaluator_id"
    t.boolean "admin_flag", default: false
    t.datetime "deletion_date"
    t.boolean "deletion_flag", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["evaluator_id"], name: "index_users_on_evaluator_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "users", "departments"
  add_foreign_key "users", "evaluators"
end
