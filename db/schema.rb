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

ActiveRecord::Schema.define(version: 2018_05_18_232416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "role", limit: 20, default: "lector"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "cod_department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_department"], name: "index_departments_on_cod_department"
  end

  create_table "issues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "name"
    t.integer "cod_municipality"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_municipality"], name: "index_municipalities_on_cod_municipality"
    t.index ["department_id"], name: "index_municipalities_on_department_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title", limit: 40
    t.string "content"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.integer "cod_post"
    t.bigint "zone_id"
    t.integer "males"
    t.integer "females"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_post"], name: "index_posts_on_cod_post"
    t.index ["zone_id"], name: "index_posts_on_zone_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "issue_id"
    t.bigint "user_id"
    t.bigint "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.bigint "municipality_id"
    t.bigint "zone_id"
    t.bigint "post_id"
    t.index ["department_id"], name: "index_reports_on_department_id"
    t.index ["issue_id"], name: "index_reports_on_issue_id"
    t.index ["municipality_id"], name: "index_reports_on_municipality_id"
    t.index ["post_id"], name: "index_reports_on_post_id"
    t.index ["table_id"], name: "index_reports_on_table_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
    t.index ["zone_id"], name: "index_reports_on_zone_id"
  end

  create_table "reset_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "used", default: false
    t.index ["token"], name: "index_reset_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_reset_tokens_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.jsonb "votes"
    t.bigint "table_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["table_id"], name: "index_results_on_table_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "cod_table"
    t.bigint "post_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_table"], name: "index_tables_on_cod_table"
    t.index ["post_id"], name: "index_tables_on_post_id"
    t.index ["user_id"], name: "index_tables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "push_token"
    t.string "name"
    t.bigint "document"
    t.boolean "coordinator"
    t.bigint "post_id"
    t.boolean "online", default: false
    t.index ["document"], name: "index_users_on_document"
    t.index ["post_id"], name: "index_users_on_post_id"
  end

  create_table "zones", force: :cascade do |t|
    t.string "name"
    t.integer "cod_zone"
    t.bigint "municipality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_zone"], name: "index_zones_on_cod_zone"
    t.index ["municipality_id"], name: "index_zones_on_municipality_id"
  end

  add_foreign_key "municipalities", "departments"
  add_foreign_key "posts", "zones"
  add_foreign_key "reports", "departments"
  add_foreign_key "reports", "issues"
  add_foreign_key "reports", "municipalities"
  add_foreign_key "reports", "posts"
  add_foreign_key "reports", "tables"
  add_foreign_key "reports", "users"
  add_foreign_key "reports", "zones"
  add_foreign_key "reset_tokens", "users"
  add_foreign_key "results", "tables"
  add_foreign_key "results", "users"
  add_foreign_key "tables", "posts"
  add_foreign_key "tables", "users"
  add_foreign_key "users", "posts"
  add_foreign_key "zones", "municipalities"
end
