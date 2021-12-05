class AddSomeColumnsInAssetsSymbolTable < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_column :asset_symbols, :country, :string
    add_column :asset_symbols, :original_logo_url, :string
    add_reference :asset_symbols, :sector, foreign_key: true, index: {algorithm: :concurrently}
  end
end
