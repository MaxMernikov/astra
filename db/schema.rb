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

ActiveRecord::Schema.define(version: 20150406180214) do

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
    t.string   "vk_token"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "pos"
    t.text     "detail"
    t.boolean  "show",                  default: false
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
    t.string   "recommendations_title"
    t.text     "recommendations"
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

  create_table "galeries", force: true do |t|
    t.integer  "product_id"
    t.integer  "lookbook_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galeries", ["lookbook_item_id"], name: "index_galeries_on_lookbook_item_id", using: :btree
  add_index "galeries", ["product_id"], name: "index_galeries_on_product_id", using: :btree

  create_table "images", force: true do |t|
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.integer  "product_id"
    t.datetime "image_updated_at"
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id", using: :btree

  create_table "insta_caches", force: true do |t|
    t.integer  "insta_user_id"
    t.string   "cache_type"
    t.text     "info_hash",     limit: 16777215
    t.string   "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "insta_caches", ["insta_user_id"], name: "index_insta_caches_on_insta_user_id", using: :btree

  create_table "insta_confs", force: true do |t|
    t.string   "token"
    t.integer  "insta_id"
    t.text     "settings_response"
    t.text     "info_response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insta_delay_works", force: true do |t|
    t.datetime "run_at"
    t.integer  "insta_user_id"
    t.string   "work_type"
    t.string   "status",        default: "hold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insta_logs", force: true do |t|
    t.integer  "insta_user_id"
    t.string   "log_type"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "point"
  end

  add_index "insta_logs", ["insta_user_id"], name: "index_insta_logs_on_insta_user_id", using: :btree
  add_index "insta_logs", ["point", "log_type"], name: "index_insta_logs_on_point_and_log_type", using: :btree

  create_table "insta_schedules", force: true do |t|
    t.datetime "run_at"
    t.integer  "insta_user_id"
    t.string   "work_type"
    t.string   "status"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "insta_schedules", ["insta_user_id"], name: "index_insta_schedules_on_insta_user_id", using: :btree

  create_table "insta_users", force: true do |t|
    t.integer  "insta_id"
    t.datetime "followed_at"
    t.datetime "unfollowed_at"
    t.boolean  "private",           default: false
    t.text     "info_hash"
    t.integer  "followed_by_count", default: 0
    t.boolean  "followed_by",       default: false
    t.boolean  "follows",           default: false
    t.boolean  "potential",         default: false
    t.boolean  "not_unsubscribe",   default: false
    t.integer  "bot_version"
    t.datetime "start_monitoring"
    t.datetime "start_follow"
    t.boolean  "not_resultative",   default: false
    t.integer  "bot_step",          default: 0
    t.integer  "insta_likes_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "insta_users", ["insta_id"], name: "index_insta_users_on_insta_id", using: :btree

  create_table "lookbook_items", force: true do |t|
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.integer  "row"
    t.text     "position"
    t.text     "background_position"
    t.integer  "product_id"
    t.string   "url"
    t.text     "comment"
    t.boolean  "show",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "y_orient",            default: false
    t.datetime "image_updated_at"
    t.boolean  "book",                default: false
  end

  add_index "lookbook_items", ["product_id"], name: "index_lookbook_items_on_product_id", using: :btree

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
    t.boolean  "show",                        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pos",                         default: 0
    t.text     "about_product"
    t.string   "description"
    t.boolean  "v3",                          default: false
    t.string   "translate"
    t.integer  "vk_owner_id"
    t.integer  "vk_photo_id"
    t.string   "vk_photo_image_file_name"
    t.string   "vk_photo_image_content_type"
    t.integer  "vk_photo_image_file_size"
    t.datetime "vk_photo_image_updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",         null: false
    t.text     "value"
    t.integer  "target_id",   null: false
    t.string   "target_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true, using: :btree

end
