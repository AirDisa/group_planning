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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130615203319) do

  create_table "conditions", :force => true do |t|
    t.string   "method",     :null => false
    t.string   "value",      :null => false
    t.integer  "invitee_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "conditions", ["invitee_id"], :name => "index_conditions_on_invitee_id"

  create_table "events", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.string   "image"
    t.datetime "commit_date"
    t.integer  "creator_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "url"
    t.text     "emails"
  end

  add_index "events", ["url"], :name => "index_events_on_url", :unique => true

  create_table "invitees", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "event_id",                          :null => false
    t.string   "status",     :default => "Pending", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "invitees", ["event_id"], :name => "index_invitees_on_event_id"
  add_index "invitees", ["user_id"], :name => "index_invitees_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",      :null => false
    t.string   "last_name",       :null => false
    t.string   "email",           :null => false
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "url"
    t.string   "profile_pic"
  end

  add_index "users", ["url"], :name => "index_users_on_url", :unique => true

end
