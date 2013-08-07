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

ActiveRecord::Schema.define(version: 20130807072835) do

  create_table "authorisations", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_messages", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  add_index "facebook_messages", ["message_id"], name: "index_facebook_messages_on_message_id"

  create_table "linkedin_messages", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  add_index "linkedin_messages", ["message_id"], name: "index_linkedin_messages_on_message_id"

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at"

  create_table "tumblr_messages", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  add_index "tumblr_messages", ["message_id"], name: "index_tumblr_messages_on_message_id"

  create_table "twitter_messages", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  add_index "twitter_messages", ["message_id"], name: "index_twitter_messages_on_message_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_me"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_me"], name: "index_users_on_remember_me"

  create_table "vkontakte_messages", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  add_index "vkontakte_messages", ["message_id"], name: "index_vkontakte_messages_on_message_id"

end
