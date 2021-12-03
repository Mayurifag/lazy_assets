class AddOngoingChangesToTables < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :transactions, :asset_symbol, foreign_key: true, null: false, index: {algorithm: :concurrently}

    change_column :asset_symbols, :symbol, :string, null: false

    add_column :asset_symbols, :last_price_in_cents, :integer

    add_column :asset_symbols, :currency, :currency # thats enum
  end
end
