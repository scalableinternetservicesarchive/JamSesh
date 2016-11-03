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

ActiveRecord::Schema.define(version: 20161101235723) do

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "spotify_id"
    t.string   "photo_url"
    t.text     "genres"
  end

  create_table "artists_profiles", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "profile_id"
    t.index ["artist_id"], name: "index_artists_profiles_on_artist_id"
    t.index ["profile_id"], name: "index_artists_profiles_on_profile_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "jam_group_id"
    t.integer  "profile_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["jam_group_id"], name: "index_comments_on_jam_group_id"
    t.index ["profile_id"], name: "index_comments_on_profile_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.string   "friendable_type"
    t.integer  "friendable_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.integer  "status"
  end

  create_table "instrument_profiles", force: :cascade do |t|
    t.integer  "instrument_id"
    t.integer  "profile_id"
    t.string   "proficiency"
    t.integer  "years"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "owned",         default: false
    t.index ["instrument_id"], name: "index_instrument_profiles_on_instrument_id"
    t.index ["profile_id"], name: "index_instrument_profiles_on_profile_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jam_group_members", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "jam_group_id"
    t.integer  "status",       default: 0
    t.integer  "invited_by"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["jam_group_id"], name: "index_jam_group_members_on_jam_group_id"
    t.index ["profile_id"], name: "index_jam_group_members_on_profile_id"
  end

  create_table "jam_groups", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "location"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "first_name", default: "Anonymous"
    t.string   "last_name",  default: "User"
    t.integer  "age",        default: 0
    t.string   "bio",        default: ""
    t.string   "phone",      default: ""
    t.integer  "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.integer  "profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_id"], name: "index_users_on_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
