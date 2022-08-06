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

ActiveRecord::Schema[7.0].define(version: 2022_08_05_041537) do
  create_table "active_sessions", force: :cascade do |t|
    t.integer "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token", null: false
    t.index ["friend_id"], name: "index_active_sessions_on_friend_id"
    t.index ["token"], name: "index_active_sessions_on_token", unique: true
  end

  create_table "friends", force: :cascade do |t|
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.integer "team", null: false
    t.integer "votes", default: 3, null: false
    t.index ["username"], name: "index_friends_on_username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "team", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category", null: false
    t.integer "option", null: false
  end

  add_foreign_key "active_sessions", "friends", on_delete: :cascade
end
