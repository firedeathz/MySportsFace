# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150517140633) do

  create_table "articles", force: :cascade do |t|
    t.string   "atom_id"
    t.string   "author"
    t.string   "title"
    t.text     "content"
    t.text     "description"
    t.string   "url"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["organization_id"], name: "index_articles_on_organization_id"

  create_table "comments", force: :cascade do |t|
    t.string   "author"
    t.text     "body"
    t.integer  "article_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"
  add_index "comments", ["user_id", "article_id", "created_at"], name: "index_comments_on_user_id_and_article_id_and_created_at"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "entries", force: :cascade do |t|
    t.string   "atom_id"
    t.string   "title"
    t.string   "url"
    t.string   "description"
    t.string   "content"
    t.integer  "feed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "entries", ["feed_id"], name: "index_entries_on_feed_id"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.decimal  "lat"
    t.decimal  "lng"
    t.date     "date"
    t.time     "time"
  end

  add_index "events", ["user_id", "created_at"], name: "index_events_on_user_id_and_created_at"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "feeds", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "status"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "feeds", ["organization_id"], name: "index_feeds_on_organization_id"

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text   "description"
    t.string "logo"
    t.string "url"
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "admin"
    t.boolean  "creator"
  end

  add_index "participations", ["event_id", "user_id"], name: "index_participations_on_event_id_and_user_id", unique: true
  add_index "participations", ["event_id"], name: "index_participations_on_event_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "url"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["event_id", "created_at"], name: "index_pictures_on_event_id_and_created_at"
  add_index "pictures", ["event_id"], name: "index_pictures_on_event_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "schedule_entries", force: :cascade do |t|
    t.time     "time"
    t.string   "description"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_entries", ["event_id", "created_at"], name: "index_schedule_entries_on_event_id_and_created_at"
  add_index "schedule_entries", ["event_id"], name: "index_schedule_entries_on_event_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
  end

end
