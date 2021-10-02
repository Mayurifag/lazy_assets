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

  create_enum :action, [
    "buy",
    "sell",
    "commission",
    "convertation",
    "dividend",
    "income",
    "other",
  ], force: :cascade

  create_enum :currency, [
    "USD",
    "RUB",
  ], force: :cascade

  create_table "asset_symbols", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.bigint "exchange_id", null: false
    t.string "last_source"
    t.jsonb "last_source_initial_attributes"
    t.string "name_en"
    t.string "name_ru"
    t.string "symbol"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exchange_id"], name: "index_asset_symbols_on_exchange_id"
    t.index ["symbol"], name: "index_asset_symbols_on_symbol", unique: true
  end

  create_table "assets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "asset_symbol_id", null: false
    t.enum "average_price_currency", enum_name: "currency"
    t.integer "average_price_in_cents", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.jsonb "other"
    t.decimal "quantity", default: "0.0", null: false
    t.jsonb "quantity_in_brokers"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asset_symbol_id"], name: "index_assets_on_asset_symbol_id", unique: true
    t.index ["quantity_in_brokers"], name: "index_assets_on_quantity_in_brokers", using: :gin
  end

  create_table "brokers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_brokers_on_name", unique: true
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "country"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "mic", null: false
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["mic"], name: "index_exchanges_on_mic", unique: true
    t.index ["name"], name: "index_exchanges_on_name", unique: true
  end

  create_table "sectors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name_en"
    t.string "name_ru"
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name_en"], name: "index_sectors_on_name_en", unique: true
    t.index ["name_ru"], name: "index_sectors_on_name_ru", unique: true
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "accured_interest_in_cents"
    t.enum "action", enum_name: "action"
    t.bigint "assets_symbols_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.enum "currency", enum_name: "currency"
    t.date "date"
    t.integer "price_commission_in_cents", default: 0, null: false
    t.integer "price_in_cents", default: 0, null: false
    t.decimal "quantity", null: false
    t.integer "total_price_in_cents", default: 0, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assets_symbols_id"], name: "index_transactions_on_assets_symbols_id"
  end

end
