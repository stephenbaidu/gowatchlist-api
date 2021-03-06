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

ActiveRecord::Schema.define(version: 2018_11_09_203653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, where: "(deleted_at IS NULL)"
  end

  create_table "visit_infos", force: :cascade do |t|
    t.bigint "watchlist_id", null: false
    t.text "previous_content", default: [], array: true
    t.text "current_content", default: [], array: true
    t.integer "visits", default: 0
    t.integer "alerts", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["watchlist_id"], name: "index_visit_infos_on_watchlist_id"
  end

  create_table "watchlists", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "selector", null: false
    t.datetime "expires_at"
    t.bigint "user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.index ["name", "user_id"], name: "index_watchlists_on_name_and_user_id", unique: true, where: "(deleted_at IS NULL)"
    t.index ["url", "user_id"], name: "index_watchlists_on_url_and_user_id", unique: true, where: "(deleted_at IS NULL)"
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "visit_infos", "watchlists"
  add_foreign_key "watchlists", "users"
end
