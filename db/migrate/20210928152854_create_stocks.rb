class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

    create_enum :action, %w[buy sell commission convertation dividend income other]
    create_enum :currency, %w[USD RUB]

    create_table :sectors do |t|
      t.string :name_ru, index: {unique: true}
      t.string :name_en, index: {unique: true}

      t.timestamps
    end

    create_table :exchanges do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :country
      t.string :mic, null: false, index: {unique: true}

      t.timestamps default: -> { "CURRENT_TIMESTAMP" }
    end

    create_table :asset_symbols do |t|
      t.string :name_ru
      t.string :name_en
      t.references :exchange, null: false
      t.string :symbol, index: {unique: true}
      t.string :last_source
      t.jsonb :last_source_initial_attributes

      t.timestamps
    end

    create_table :brokers do |t|
      t.string :name, null: false, index: {unique: true}

      t.timestamps default: -> { "CURRENT_TIMESTAMP" }
    end

    create_table :assets, id: :uuid do |t|
      t.integer :average_price_in_cents, null: false, default: 0
      t.enum :average_price_currency, enum_name: :currency
      t.decimal :quantity, null: false, default: 0
      t.references :asset_symbol, null: false, index: {unique: true}
      t.jsonb :quantity_in_brokers
      t.jsonb :other

      t.timestamps
    end
    add_index :assets, :quantity_in_brokers, using: :gin

    create_table :transactions, id: :uuid do |t|
      t.enum :action, enum_name: :action
      t.references :assets_symbols, null: false
      t.decimal :quantity, null: false
      t.integer :price_in_cents, null: false, default: 0
      t.integer :total_price_in_cents, null: false, default: 0
      t.integer :price_commission_in_cents, null: false, default: 0
      t.integer :accured_interest_in_cents
      t.enum :currency, enum_name: :currency
      t.date :date

      t.timestamps
    end
  end
end
