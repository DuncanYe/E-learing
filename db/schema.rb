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

ActiveRecord::Schema.define(version: 2020_02_21_084708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", comment: "類別名稱"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false, comment: "主題"
    t.text "desc", default: "", comment: "描述"
    t.string "url", comment: "URL"
    t.string "state", null: false, comment: "狀態"
    t.integer "price", null: false, comment: "價錢"
    t.string "currency", null: false, comment: "幣別"
    t.datetime "available_day", null: false, comment: "使用期限"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["category_id"], name: "index_courses_on_category_id"
  end

  create_table "user_courses", force: :cascade do |t|
    t.datetime "end_at", null: false, comment: "結束時間"
    t.string "state", null: false, comment: "狀態"
    t.integer "amount", null: false, comment: "金額"
    t.text "note", comment: "備註"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_courses_on_category_id"
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.string "authentication_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "categories"
  add_foreign_key "user_courses", "categories"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
end
