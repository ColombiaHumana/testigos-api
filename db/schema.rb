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

ActiveRecord::Schema.define(version: 2018_04_26_224050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "cod_department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_department"], name: "index_departments_on_cod_department"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "name"
    t.integer "cod_department"
    t.integer "cod_municipality"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_department"], name: "index_municipalities_on_cod_department"
    t.index ["cod_municipality"], name: "index_municipalities_on_cod_municipality"
    t.index ["department_id"], name: "index_municipalities_on_department_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title", limit: 20
    t.string "content"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.bigint "zone_id"
    t.bigint "municipality_id"
    t.bigint "department_id"
    t.integer "mesas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mens"
    t.integer "womens"
    t.string "address"
    t.integer "cod_post"
    t.index ["cod_post"], name: "index_posts_on_cod_post"
    t.index ["department_id"], name: "index_posts_on_department_id"
    t.index ["municipality_id"], name: "index_posts_on_municipality_id"
    t.index ["zone_id"], name: "index_posts_on_zone_id"
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

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.integer "cod_department"
    t.integer "cod_municipality"
    t.integer "cod_zone"
    t.integer "cod_table"
    t.bigint "municipality_id"
    t.bigint "department_id"
    t.bigint "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "post_id"
    t.integer "table_number"
    t.index ["cod_department"], name: "index_tables_on_cod_department"
    t.index ["cod_municipality"], name: "index_tables_on_cod_municipality"
    t.index ["cod_table"], name: "index_tables_on_cod_table"
    t.index ["cod_zone"], name: "index_tables_on_cod_zone"
    t.index ["department_id"], name: "index_tables_on_department_id"
    t.index ["municipality_id"], name: "index_tables_on_municipality_id"
    t.index ["post_id"], name: "index_tables_on_post_id"
    t.index ["user_id"], name: "index_tables_on_user_id"
    t.index ["zone_id"], name: "index_tables_on_zone_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "push_token"
    t.bigint "post_id"
    t.bigint "zone_id"
    t.bigint "municipality_id"
    t.bigint "department_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["municipality_id"], name: "index_users_on_municipality_id"
    t.index ["post_id"], name: "index_users_on_post_id"
    t.index ["zone_id"], name: "index_users_on_zone_id"
  end

  create_table "zones", force: :cascade do |t|
    t.string "name"
    t.integer "cod_department"
    t.integer "cod_municipality"
    t.integer "cod_zone"
    t.bigint "municipality_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cod_department"], name: "index_zones_on_cod_department"
    t.index ["cod_municipality"], name: "index_zones_on_cod_municipality"
    t.index ["cod_zone"], name: "index_zones_on_cod_zone"
    t.index ["department_id"], name: "index_zones_on_department_id"
    t.index ["municipality_id"], name: "index_zones_on_municipality_id"
  end

  add_foreign_key "municipalities", "departments"
  add_foreign_key "posts", "departments"
  add_foreign_key "posts", "municipalities"
  add_foreign_key "posts", "zones"
  add_foreign_key "reset_tokens", "users"
  add_foreign_key "tables", "departments"
  add_foreign_key "tables", "municipalities"
  add_foreign_key "tables", "posts"
  add_foreign_key "tables", "users"
  add_foreign_key "tables", "zones"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "municipalities"
  add_foreign_key "users", "posts"
  add_foreign_key "users", "zones"
  add_foreign_key "zones", "departments"
  add_foreign_key "zones", "municipalities"
end
