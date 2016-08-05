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

ActiveRecord::Schema.define(version: 20160805050947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",           :index=>{:name=>"index_users_on_email", :unique=>true}
    t.string   "password_digest"
    t.datetime "created_at",      :null=>false
    t.datetime "updated_at",      :null=>false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",      :null=>false
    t.datetime "updated_at",      :null=>false
    t.integer  "user_id",         :index=>{:name=>"index_events_on_user_id"}, :foreign_key=>{:references=>"users", :name=>"fk_rails_0cb5590091", :on_update=>:no_action, :on_delete=>:no_action}
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "suggested_price"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "notify",          :default=>false
  end

  create_table "parkingspots", force: :cascade do |t|
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "user_id",       :index=>{:name=>"index_parkingspots_on_user_id"}, :foreign_key=>{:references=>"users", :name=>"fk_rails_6efd4bc4e6", :on_update=>:no_action, :on_delete=>:no_action}
    t.datetime "created_at",    :null=>false
    t.datetime "updated_at",    :null=>false
    t.string   "title"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.text     "description"
    t.float    "default_price"
    t.boolean  "notification",  :default=>false
  end

  create_table "rentals", force: :cascade do |t|
    t.float    "price"
    t.integer  "parkingspot_id", :index=>{:name=>"index_rentals_on_parkingspot_id"}, :foreign_key=>{:references=>"parkingspots", :name=>"fk_rails_953a1681f6", :on_update=>:no_action, :on_delete=>:no_action}
    t.datetime "created_at",     :null=>false
    t.datetime "updated_at",     :null=>false
    t.integer  "event_id",       :index=>{:name=>"index_rentals_on_event_id"}, :foreign_key=>{:references=>"events", :name=>"fk_rails_01a319cf6a", :on_update=>:no_action, :on_delete=>:no_action}
    t.integer  "user_id",        :index=>{:name=>"index_rentals_on_user_id"}, :foreign_key=>{:references=>"users", :name=>"fk_rentals_user_id", :on_update=>:no_action, :on_delete=>:no_action}
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "plateNumber"
  end

end
