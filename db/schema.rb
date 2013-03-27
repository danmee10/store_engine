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

ActiveRecord::Schema.define(:version => 20130327013001) do

  create_table "cart_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cart_products", ["cart_id"], :name => "index_cart_products_on_cart_id"
  add_index "cart_products", ["product_id"], :name => "index_cart_products_on_product_id"

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "session_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_categories", :force => true do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "product_categories", ["category_id"], :name => "index_product_categories_on_category_id"
  add_index "product_categories", ["product_id"], :name => "index_product_categories_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.float    "price"
    t.string   "photo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email",            :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
