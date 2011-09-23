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

ActiveRecord::Schema.define(:version => 20110923005024) do

  create_table "doctors", :force => true do |t|
    t.string   "doctorname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", :force => true do |t|
    t.string   "formname"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iforms", :force => true do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "middlename"
    t.string   "prefix"
    t.string   "preferredname"
    t.string   "sex"
    t.integer  "age"
    t.string   "ssn"
    t.string   "homeadd"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "relationshipstatus"
    t.string   "homeph"
    t.string   "pager"
    t.string   "workph"
    t.string   "workext"
    t.string   "license"
    t.string   "employer"
    t.string   "empadd"
    t.string   "empduration"
    t.string   "occupation"
    t.string   "generaldentist"
    t.string   "referal"
    t.string   "familyvisited"
    t.string   "reachyou"
    t.date     "todaydate"
    t.date     "birthdate"
    t.date     "lastvisitdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "path"
  end

  create_table "patients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
