# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_28_152854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"



  create_table "bonds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "average_price_currency", default: "USD", null: false
    t.integer "average_price_in_cents", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.string "isin"
    t.jsonb "other"
    t.integer "quantity", default: 0, null: false
    t.jsonb "quantity_in_brokers"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quantity_in_brokers"], name: "index_bonds_on_quantity_in_brokers", using: :gin
  end

  create_table "brokers", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_brokers_on_name"
  end

  create_table "gics_sectors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.jsonb "translations", default: {}, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["translations"], name: "index_gics_sectors_on_translations", using: :gin
  end

  create_table "stock_ticker_symbols", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.bigint "gics_sector_id"
    t.jsonb "translations", default: {}, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gics_sector_id"], name: "index_stock_ticker_symbols_on_gics_sector_id"
    t.index ["translations"], name: "index_stock_ticker_symbols_on_translations", using: :gin
  end

  create_table "stocks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "average_price_currency", default: "USD", null: false
    t.integer "average_price_in_cents", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.jsonb "other"
    t.integer "quantity", default: 0, null: false
    t.jsonb "quantity_in_brokers"
    t.bigint "stock_ticker_symbol_id"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quantity_in_brokers"], name: "index_stocks_on_quantity_in_brokers", using: :gin
    t.index ["stock_ticker_symbol_id"], name: "index_stocks_on_stock_ticker_symbol_id"
  end

end
