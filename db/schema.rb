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

ActiveRecord::Schema.define(:version => 20110817220731) do

  create_table "confirmations", :force => true do |t|
    t.string   "code"
    t.string   "action"
    t.string   "confirmable_type"
    t.integer  "confirmable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facebook_request_id", :limit => 8
  end

  create_table "games", :force => true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "play_date"
    t.string   "game_type",   :default => "friendly"
    t.string   "description"
    t.string   "status"
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

  create_table "results", :force => true do |t|
    t.integer  "game_id"
    t.text     "result_sets"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
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
