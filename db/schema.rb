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

ActiveRecord::Schema.define(version: 20150105082814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "old_pages", force: :cascade do |t|
    t.text     "body"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "old_pages", ["page_id"], name: "index_old_pages_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "parent_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["deleted_at"], name: "index_pages_on_deleted_at", using: :btree
  add_index "pages", ["parent_id", "deleted_at"], name: "index_pages_on_parent_id_and_deleted_at", using: :btree
  add_index "pages", ["title", "deleted_at"], name: "index_pages_on_title_and_deleted_at", using: :btree

end
