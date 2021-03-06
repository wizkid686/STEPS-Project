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

ActiveRecord::Schema.define(version: 20160517014727) do

  create_table "courses", force: :cascade do |t|
    t.string   "course_name"
    t.integer  "course_sequence_number"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "period"
  end

  add_index "courses", ["period"], name: "index_courses_on_period"
  add_index "courses", ["user_id", "course_name"], name: "index_courses_on_user_id_and_course_name"
  add_index "courses", ["user_id"], name: "index_courses_on_user_id"

  create_table "courses_students", id: false, force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
  end

  add_index "courses_students", ["course_id", "student_id"], name: "index_courses_students_on_course_id_and_student_id", unique: true
  add_index "courses_students", ["course_id"], name: "index_courses_students_on_course_id"
  add_index "courses_students", ["student_id"], name: "index_courses_students_on_student_id"

  create_table "passes", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "destination"
    t.datetime "time_out"
    t.boolean  "returning"
    t.datetime "return_time"
    t.integer  "user_id"
    t.integer  "student_id"
  end

  add_index "passes", ["student_id"], name: "index_passes_on_student_id"
  add_index "passes", ["user_id"], name: "index_passes_on_user_id"

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "student_number"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "school_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_number"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "subject_area"
    t.string   "instructional_level"
    t.string   "school_name"
    t.string   "location"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["location"], name: "index_users_on_location"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
