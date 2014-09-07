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

ActiveRecord::Schema.define(version: 20140907193806) do

  create_table "about_product_images", force: true do |t|
    t.integer  "category_id"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
  end

  add_index "about_product_images", ["category_id"], name: "index_about_product_images_on_category_id", using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "pos"
    t.text     "detail"
    t.boolean  "show",               default: false
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "detail_product"
    t.text     "sub_detail"
    t.string   "plural_title"
    t.string   "genitive"
    t.string   "dative"
    t.string   "accusative"
    t.string   "instrumental"
    t.string   "prepositional"
    t.string   "description"
    t.string   "keywords"
    t.string   "more_info"
  end

  create_table "categories_cloths", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "cloth_id"
  end

  add_index "categories_cloths", ["category_id"], name: "index_categories_cloths_on_category_id", using: :btree
  add_index "categories_cloths", ["cloth_id"], name: "index_categories_cloths_on_cloth_id", using: :btree

  create_table "cloths", force: true do |t|
    t.boolean  "show",               default: true
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.string   "referal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string  "image_file_name"
    t.integer "image_file_size"
    t.string  "image_content_type"
    t.integer "product_id"
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "product_id"
    t.integer  "cloth_id"
    t.string   "email"
    t.string   "phone"
    t.string   "name"
    t.text     "details"
    t.text     "mark"
    t.boolean  "complete",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["cloth_id"], name: "index_orders_on_cloth_id", using: :btree
  add_index "orders", ["product_id"], name: "index_orders_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "title"
    t.integer  "category_id"
    t.integer  "cost"
    t.boolean  "show",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pos",           default: 0
    t.text     "about_product"
    t.string   "description"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

end
