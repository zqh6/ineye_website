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

ActiveRecord::Schema.define(version: 20170718064237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "dictionaries", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "dictionary_type", limit: 50, default: "", null: false
    t.string "name", limit: 50, default: "", null: false
    t.string "code", limit: 50, default: "", null: false
    t.integer "value", default: 0, null: false
    t.string "state", limit: 1, default: "C", null: false
    t.datetime "opened_at", default: "1970-01-01 00:00:00", null: false
    t.datetime "closed_at", default: "3000-01-01 00:00:00", null: false
    t.boolean "defunct", default: false, null: false
    t.jsonb "notation", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_dictionaries_on_code"
    t.index ["dictionary_type"], name: "index_dictionaries_on_dictionary_type"
  end

  create_table "news", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "title", limit: 255, default: "", null: false
    t.string "vice_title", limit: 255
    t.string "key_words", limit: 255
    t.datetime "occurred_at", default: "1970-01-01 00:00:00", null: false
    t.integer "classify"
    t.text "content"
    t.string "state", limit: 1, default: "C", null: false
    t.datetime "opened_at", default: "1970-01-01 00:00:00", null: false
    t.datetime "closed_at", default: "3000-01-01 00:00:00", null: false
    t.boolean "defunct", default: false, null: false
    t.jsonb "notation", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_news_on_user_id"
  end

  create_table "passwords", id: :serial, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "pepper_content", limit: 128, default: "", null: false
    t.string "hashed_content", limit: 128, default: "", null: false
    t.string "state", limit: 1, default: "C", null: false
    t.datetime "opened_at", default: "1970-01-01 00:00:00", null: false
    t.datetime "closed_at", default: "3000-01-01 00:00:00", null: false
    t.boolean "defunct", default: false, null: false
    t.jsonb "notation", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_passwords_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "create_user_id"
    t.string "role_code", limit: 20, default: ""
    t.string "name", limit: 50
    t.string "phone_number", limit: 50, default: "", null: false
    t.string "state", limit: 1, default: "C", null: false
    t.datetime "opened_at", default: "1970-01-01 00:00:00", null: false
    t.datetime "closed_at", default: "3000-01-01 00:00:00", null: false
    t.boolean "defunct", default: false, null: false
    t.jsonb "notation", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["create_user_id"], name: "index_users_on_create_user_id"
    t.index ["name"], name: "index_users_on_name"
    t.index ["phone_number"], name: "index_users_on_phone_number"
    t.index ["user_id"], name: "index_users_on_user_id"
  end

end
