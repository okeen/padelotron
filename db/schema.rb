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

ActiveRecord::Schema.define(:version => 20110823233817) do

  create_table "achievement_types", :force => true do |t|
    t.string   "name"
    t.string   "nature"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "achievements", :force => true do |t|
    t.integer  "stat_id"
    t.integer  "achievement_type_id"
    t.boolean  "read",                :default => false
    t.text     "message"
    t.datetime "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confirmations", :force => true do |t|
    t.string   "code"
    t.string   "action"
    t.string   "confirmable_type"
    t.integer  "confirmable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "facebook_request_id"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "play_date"
    t.string   "game_type",                          :default => "friendly"
    t.string   "description",                        :default => ""
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "winner_team_id"
    t.boolean  "create_facebook_event"
    t.integer  "facebook_event_id",     :limit => 8
    t.string   "facebook_requets_ids"
    t.integer  "playground_id"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "street"
    t.string   "full_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.integer  "facebook_id",         :limit => 8
    t.string   "extra_field"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "remember_created_at"
  end

  create_table "playgrounds", :force => true do |t|
    t.string   "name"
    t.string   "sport"
    t.integer  "number"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "game_id"
    t.text     "result_sets"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", :force => true do |t|
    t.string   "statable_type"
    t.integer  "statable_id"
    t.integer  "wins",          :default => 0
    t.integer  "lost",          :default => 0
    t.float    "win_percent",   :default => 0.0
    t.integer  "win_strike",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lost_strike",   :default => 0
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

end
