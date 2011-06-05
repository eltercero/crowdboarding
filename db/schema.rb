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

ActiveRecord::Schema.define(:version => 20110605163509) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true

  create_table "attendances", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["event_id"], :name => "index_attendances_on_event_id"
  add_index "attendances", ["user_id"], :name => "index_attendances_on_user_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider",   :limit => 20
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "cities", :force => true do |t|
    t.string "name", :limit => 100, :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "ancestry"
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type", :limit => 14
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "countries", :force => true do |t|
    t.string "name",         :null => false
    t.string "country_code", :null => false
  end

  add_index "countries", ["country_code"], :name => "index_countries_on_country_code", :unique => true
  add_index "countries", ["name"], :name => "index_countries_on_name", :unique => true

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",            :limit => 100
    t.datetime "starts_at"
    t.text     "description"
    t.string   "address",         :limit => 100
    t.integer  "country_id"
    t.string   "city_name",       :limit => 100
    t.string   "contact_details", :limit => 100
    t.float    "lat"
    t.float    "lng"
    t.integer  "users_count",                    :default => 0
    t.integer  "comments_count",                 :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["country_id"], :name => "index_events_on_country_id"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.integer  "friend_id",                :null => false
    t.string   "type",       :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "body",       :limit => 100
    t.boolean  "read",                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", :limit => 20
    t.integer  "tagger_id"
    t.string   "tagger_type",   :limit => 20
    t.string   "context",       :limit => 20
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                   :limit => 100
    t.string   "nickname",               :limit => 40
    t.text     "bio"
    t.text     "quiver"
    t.date     "birthdate"
    t.integer  "default_city_id"
    t.integer  "profile_views",                         :default => 0
    t.boolean  "event_friend_updates"
    t.string   "users"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
