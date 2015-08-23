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

ActiveRecord::Schema.define(version: 20150823181937) do

  create_table "option_types", force: :cascade do |t|
    t.string   "name"
    t.string   "presentation"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "option_values", force: :cascade do |t|
    t.string   "name"
    t.string   "presentation"
    t.integer  "position"
    t.integer  "option_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "option_values", ["option_type_id"], name: "index_option_values_on_option_type_id"

  create_table "product_option_types", force: :cascade do |t|
    t.integer  "position"
    t.integer  "product_id"
    t.integer  "option_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "product_option_types", ["option_type_id"], name: "index_product_option_types_on_option_type_id"
  add_index "product_option_types", ["product_id"], name: "index_product_option_types_on_product_id"

  create_table "product_properties", force: :cascade do |t|
    t.string   "value"
    t.integer  "position"
    t.integer  "product_id"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "product_properties", ["product_id"], name: "index_product_properties_on_product_id"
  add_index "product_properties", ["property_id"], name: "index_product_properties_on_property_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "available_on"
    t.date     "available_until"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.string   "presentation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "variants", force: :cascade do |t|
    t.string   "sku"
    t.boolean  "is_master"
    t.decimal  "price",      precision: 10, scale: 2
    t.integer  "position"
    t.integer  "product_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id"

end
