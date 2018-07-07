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

ActiveRecord::Schema.define(version: 20180707084302) do

  create_table "activity_enters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "activity_type",                                           null: false
    t.string   "state",         limit: 1, default: "C",                   null: false
    t.datetime "opened_at",               default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",               default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                 default: false,                 null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "ip"
    t.string   "remote_ip"
    t.string   "user_agent"
    t.string   "dian_hua"
    t.datetime "ordered_at"
    t.string   "description"
    t.index ["activity_type"], name: "index_activity_enters_on_activity_type", using: :btree
    t.index ["name"], name: "index_activity_enters_on_name", using: :btree
    t.index ["phone_number"], name: "index_activity_enters_on_phone_number", using: :btree
  end

  create_table "ask_for_leaves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                              null: false
    t.string   "am_pm_code",                                           null: false
    t.datetime "day",                                                  null: false
    t.string   "state",      limit: 1, default: "C",                   null: false
    t.datetime "opened_at",            default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",            default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",              default: false,                 null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "office_id",            default: 0,                     null: false
    t.index ["am_pm_code"], name: "index_ask_for_leaves_on_am_pm_code", using: :btree
    t.index ["day"], name: "index_ask_for_leaves_on_day", using: :btree
    t.index ["defunct"], name: "index_ask_for_leaves_on_defunct", using: :btree
    t.index ["office_id"], name: "index_ask_for_leaves_on_office_id", using: :btree
    t.index ["state"], name: "index_ask_for_leaves_on_state", using: :btree
    t.index ["user_id"], name: "index_ask_for_leaves_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "parent_id"
    t.text     "content",    limit: 4294967295
    t.string   "post_link"
    t.string   "post_id"
    t.integer  "creator_id"
    t.integer  "auditor_id"
    t.string   "state",      limit: 1,          default: "C",   null: false
    t.boolean  "defunct",                       default: false, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "con_education_articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "article_classify",                                                    null: false
    t.string   "article_type",                                                        null: false
    t.string   "static_url"
    t.string   "title",                                                               null: false
    t.text     "content",          limit: 4294967295
    t.string   "pdf_url"
    t.string   "video_url"
    t.datetime "published_at"
    t.string   "state",            limit: 1,          default: "C",                   null: false
    t.datetime "opened_at",                           default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",                           default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                             default: false,                 null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.index ["article_classify"], name: "index_con_education_articles_on_article_classify", using: :btree
    t.index ["article_type"], name: "index_con_education_articles_on_article_type", using: :btree
    t.index ["published_at"], name: "index_con_education_articles_on_published_at", using: :btree
    t.index ["static_url"], name: "index_con_education_articles_on_static_url", using: :btree
    t.index ["title"], name: "index_con_education_articles_on_title", using: :btree
  end

  create_table "dictionaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "dictionary_type", limit: 50, default: "",                    null: false
    t.string   "name",            limit: 50, default: "",                    null: false
    t.string   "code",            limit: 50, default: "",                    null: false
    t.integer  "value",                      default: 0,                     null: false
    t.string   "state",           limit: 1,  default: "C",                   null: false
    t.datetime "opened_at",                  default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",                  default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                    default: false,                 null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.index ["code"], name: "index_dictionaries_on_code", using: :btree
    t.index ["dictionary_type"], name: "index_dictionaries_on_dictionary_type", using: :btree
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title",                            default: "",                    null: false
    t.string   "vice_title"
    t.string   "key_words"
    t.datetime "occurred_at",                      default: '1970-01-01 00:00:00', null: false
    t.string   "classify"
    t.text     "content",         limit: 16777215
    t.string   "state",           limit: 1,        default: "C",                   null: false
    t.datetime "opened_at",                        default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",                        default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                          default: false,                 null: false
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.string   "scan_file_id"
    t.string   "scan_rails_path"
    t.string   "aim_at_platform"
    t.index ["user_id"], name: "index_news_on_user_id", using: :btree
  end

  create_table "office_times", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "office_id",                                            null: false
    t.string   "am_pm_code",                                           null: false
    t.string   "state",      limit: 1, default: "C",                   null: false
    t.datetime "opened_at",            default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",            default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",              default: false,                 null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["am_pm_code"], name: "index_office_times_on_am_pm_code", using: :btree
    t.index ["closed_at"], name: "index_office_times_on_closed_at", using: :btree
    t.index ["created_at"], name: "index_office_times_on_created_at", using: :btree
    t.index ["defunct"], name: "index_office_times_on_defunct", using: :btree
    t.index ["office_id"], name: "index_office_times_on_office_id", using: :btree
    t.index ["opened_at"], name: "index_office_times_on_opened_at", using: :btree
    t.index ["state"], name: "index_office_times_on_state", using: :btree
  end

  create_table "office_user_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "office_id",                                            null: false
    t.integer  "user_id",                                              null: false
    t.string   "state",      limit: 1, default: "C",                   null: false
    t.datetime "opened_at",            default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",            default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",              default: false,                 null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "offices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                 default: "",                    null: false
    t.string   "vice_name"
    t.string   "state",      limit: 1, default: "C",                   null: false
    t.datetime "opened_at",            default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",            default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",              default: false,                 null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["defunct"], name: "index_offices_on_defunct", using: :btree
    t.index ["name"], name: "index_offices_on_name", using: :btree
    t.index ["state"], name: "index_offices_on_state", using: :btree
  end

  create_table "passwords", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                                    null: false
    t.string   "pepper_content", limit: 128, default: "",                    null: false
    t.string   "hashed_content", limit: 128, default: "",                    null: false
    t.string   "state",          limit: 1,   default: "C",                   null: false
    t.datetime "opened_at",                  default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",                  default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                    default: false,                 null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.index ["user_id"], name: "index_passwords_on_user_id", using: :btree
  end

  create_table "schedulings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "office_time_id",                                                    null: false
    t.integer  "user_id",                                                           null: false
    t.string   "week_code",                                                         null: false
    t.string   "outpatient_service_type"
    t.string   "state",                   limit: 1, default: "C",                   null: false
    t.datetime "opened_at",                         default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",                         default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                           default: false,                 null: false
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.integer  "office_id",                                                         null: false
    t.string   "am_pm_code",                                                        null: false
    t.index ["am_pm_code"], name: "index_schedulings_on_am_pm_code", using: :btree
    t.index ["defunct"], name: "index_schedulings_on_defunct", using: :btree
    t.index ["office_id"], name: "index_schedulings_on_office_id", using: :btree
    t.index ["office_time_id"], name: "index_schedulings_on_office_time_id", using: :btree
    t.index ["outpatient_service_type"], name: "index_schedulings_on_outpatient_service_type", using: :btree
    t.index ["state"], name: "index_schedulings_on_state", using: :btree
    t.index ["user_id"], name: "index_schedulings_on_user_id", using: :btree
    t.index ["week_code"], name: "index_schedulings_on_week_code", using: :btree
  end

  create_table "statistics_urls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url",                                                  null: false
    t.integer  "count",                default: 0,                     null: false
    t.string   "state",      limit: 1, default: "C",                   null: false
    t.datetime "opened_at",            default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",            default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",              default: false,                 null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["url"], name: "index_statistics_urls_on_url", using: :btree
  end

  create_table "tag_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "relation_type",                                           null: false
    t.string   "relation_id",                                             null: false
    t.string   "tag_name",                                                null: false
    t.string   "state",         limit: 1, default: "C",                   null: false
    t.datetime "opened_at",               default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",               default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                 default: false,                 null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "tag_flag"
    t.index ["relation_id"], name: "index_tag_relations_on_relation_id", using: :btree
    t.index ["relation_type"], name: "index_tag_relations_on_relation_type", using: :btree
    t.index ["tag_flag"], name: "index_tag_relations_on_tag_flag", using: :btree
    t.index ["tag_name"], name: "index_tag_relations_on_tag_name", using: :btree
  end

  create_table "url_counts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url",           limit: 500, default: "",                    null: false
    t.string   "suffix_params",             default: "",                    null: false
    t.string   "method",                    default: "",                    null: false
    t.integer  "count",                     default: 0,                     null: false
    t.string   "state",         limit: 1,   default: "C",                   null: false
    t.datetime "opened_at",                 default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",                 default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                   default: false,                 null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "model_name2"
    t.integer  "model_id"
    t.index ["model_id"], name: "index_url_counts_on_model_id", using: :btree
    t.index ["model_name2"], name: "index_url_counts_on_model_name2", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "create_user_id"
    t.string   "role_code",                 limit: 20,    default: ""
    t.string   "name",                      limit: 50
    t.string   "phone_number",              limit: 50,    default: "",                    null: false
    t.string   "state",                     limit: 1,     default: "C",                   null: false
    t.datetime "opened_at",                               default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",                               default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                                 default: false,                 null: false
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.string   "linked_url"
    t.text     "honour_brief_introduction", limit: 65535
    t.text     "honour_specific",           limit: 65535
    t.text     "good_at_field",             limit: 65535
    t.text     "work_time",                 limit: 65535
    t.text     "detailed_introduction",     limit: 65535
    t.string   "unit_name"
    t.string   "official_account",                                                        null: false
    t.integer  "user_order",                              default: 0
    t.string   "doctor_level"
    t.index ["create_user_id"], name: "index_users_on_create_user_id", using: :btree
    t.index ["doctor_level"], name: "index_users_on_doctor_level", using: :btree
    t.index ["name"], name: "index_users_on_name", using: :btree
    t.index ["phone_number"], name: "index_users_on_phone_number", using: :btree
    t.index ["user_id"], name: "index_users_on_user_id", using: :btree
  end

  create_table "validate_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "phone_number",                                            null: false
    t.string   "validate_code"
    t.string   "state",         limit: 1, default: "C",                   null: false
    t.datetime "opened_at",               default: '1970-01-01 00:00:00', null: false
    t.datetime "closed_at",               default: '3000-01-01 00:00:00', null: false
    t.boolean  "defunct",                 default: false,                 null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

end
