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

ActiveRecord::Schema.define(version: 20170226041644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "notes"
    t.string   "artist"
    t.string   "promotion"
    t.index ["user_id"], name: "index_campaigns_on_user_id", using: :btree
  end

  create_table "counters", force: :cascade do |t|
    t.string  "name"
    t.integer "count"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genre_tags", force: :cascade do |t|
    t.integer  "writer_id"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_tags_on_genre_id", using: :btree
    t.index ["writer_id"], name: "index_genre_tags_on_writer_id", using: :btree
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "outlet_id"
    t.integer  "writer_id"
    t.string   "email_work"
    t.string   "position"
    t.string   "outlet_profile"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "key_contact"
    t.string   "secondary_email_work"
    t.string   "notes"
    t.index ["outlet_id"], name: "index_jobs_on_outlet_id", using: :btree
    t.index ["writer_id"], name: "index_jobs_on_writer_id", using: :btree
  end

  create_table "outlets", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "website"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.integer  "country_id"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "linkedin"
    t.string   "twitter_followers"
    t.string   "facebook_likes"
    t.string   "instagram_followers"
    t.boolean  "hype_m",              default: false
    t.boolean  "submithub",           default: false
    t.boolean  "flagged",             default: false
    t.boolean  "inactive",            default: false
    t.string   "notes"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "description"
    t.string   "staff_list"
    t.integer  "user_id"
    t.string   "second_email"
    t.string   "third_email"
    t.index ["country_id"], name: "index_outlets_on_country_id", using: :btree
    t.index ["user_id"], name: "index_outlets_on_user_id", using: :btree
  end

  create_table "presstype_tags", force: :cascade do |t|
    t.integer  "presstype_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "job_id"
    t.index ["job_id"], name: "index_presstype_tags_on_job_id", using: :btree
    t.index ["presstype_id"], name: "index_presstype_tags_on_presstype_id", using: :btree
  end

  create_table "presstypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_jobs", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "job_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "response"
    t.datetime "response_updated_at"
    t.string   "followed_up"
    t.index ["campaign_id"], name: "index_saved_jobs_on_campaign_id", using: :btree
    t.index ["job_id"], name: "index_saved_jobs_on_job_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "admin",                  default: false,   null: false
    t.boolean  "trial",                  default: false,   null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "writers", force: :cascade do |t|
    t.string   "f_name",                            null: false
    t.string   "l_name"
    t.string   "city"
    t.string   "state"
    t.integer  "country_id"
    t.string   "twitter"
    t.string   "linkedin"
    t.boolean  "freelance",         default: false
    t.boolean  "flagged",           default: false
    t.boolean  "inactive",          default: false
    t.string   "notes"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id"
    t.string   "email_personal"
    t.string   "twitter_followers"
    t.string   "personal_website"
    t.index ["country_id"], name: "index_writers_on_country_id", using: :btree
    t.index ["user_id"], name: "index_writers_on_user_id", using: :btree
  end

  add_foreign_key "genre_tags", "genres"
  add_foreign_key "genre_tags", "writers"
  add_foreign_key "jobs", "outlets"
  add_foreign_key "jobs", "writers"
  add_foreign_key "presstype_tags", "jobs"
  add_foreign_key "presstype_tags", "presstypes"
end
