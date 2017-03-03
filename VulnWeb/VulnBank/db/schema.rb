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

ActiveRecord::Schema.define(version: 20170301203911) do

  create_table "accounts", force: :cascade do |t|
    t.string   "acct_number"
    t.string   "status"
    t.decimal  "balance"
    t.string   "owner"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "borrows", force: :cascade do |t|
    t.string   "to_account"
    t.string   "from_account"
    t.string   "requestor"
    t.string   "requestee"
    t.float    "amount"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "deposits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "admin_id"
    t.string   "status"
    t.date     "date"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "admin_id"
    t.string   "status"
    t.float    "amount"
    t.date     "start"
    t.date     "effective"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "admin"
    t.boolean  "master",          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "withdrawals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "admin_id"
    t.string   "status"
    t.date     "date"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
