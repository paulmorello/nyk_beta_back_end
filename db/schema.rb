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

ActiveRecord::Schema.define(version: 20160922171133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_primary", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "genres_writers", id: false, force: :cascade do |t|
    t.integer "genre_id",  null: false
    t.integer "writer_id", null: false
  end

  create_table "outlets", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "website"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "linkedin"
    t.integer  "twitter_followers"
    t.integer  "facebook_likes"
    t.integer  "instagram_followers"
    t.boolean  "hype_m",              default: false
    t.boolean  "submithub",           default: false
    t.boolean  "flagged",             default: false
    t.boolean  "inactive",            default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "outlets_writers", id: false, force: :cascade do |t|
    t.integer "outlet_id", null: false
    t.integer "writer_id", null: false
  end

  create_table "presstypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "presstypes_writers", id: false, force: :cascade do |t|
    t.integer "presstype_id", null: false
    t.integer "writer_id",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "label_url"
    t.boolean  "admin",                  default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "writers", force: :cascade do |t|
    t.string   "f_name",                         null: false
    t.string   "l_name",                         null: false
    t.string   "position"
    t.string   "website"
    t.string   "email_work",                     null: false
    t.string   "email_personal"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "linkedin"
    t.boolean  "key_contact",    default: false
    t.boolean  "freelance",      default: false
    t.boolean  "flagged",        default: false
    t.boolean  "inactive",       default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
