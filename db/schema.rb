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

ActiveRecord::Schema[7.0].define(version: 2024_01_20_182201) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.float "amount"
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

  create_table "kaizen_reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "subject"
    t.date "submission_date"
    t.text "before_text"
    t.text "after_text"
    t.string "before_image"
    t.string "after_image"
    t.text "effect_comment"
    t.float "cost"
    t.float "effect_amount"
    t.bigint "tsk_value_id", null: false
    t.bigint "evaluator_progress_id", null: false
    t.string "evaluators_id"
    t.text "evaluation_comment"
    t.string "kaizen_member_id"
    t.bigint "award_id", null: false
    t.bigint "department_id", null: false
    t.datetime "deletion_date"
    t.boolean "deletion_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "submission_flag", default: false
    t.index ["award_id"], name: "index_kaizen_reports_on_award_id"
    t.index ["department_id"], name: "index_kaizen_reports_on_department_id"
    t.index ["evaluator_progress_id"], name: "index_kaizen_reports_on_evaluator_progress_id"
    t.index ["tsk_value_id"], name: "index_kaizen_reports_on_tsk_value_id"
    t.index ["user_id"], name: "index_kaizen_reports_on_user_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "kaizen_reports", "awards"
  add_foreign_key "kaizen_reports", "departments"
  add_foreign_key "kaizen_reports", "evaluator_progresses"
  add_foreign_key "kaizen_reports", "tsk_values"
  add_foreign_key "kaizen_reports", "users"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "evaluators"
end
