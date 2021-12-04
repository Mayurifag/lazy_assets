module Types
  class AssetType < Types::BaseObject
    field :id, ID, null: false
    field :average_price_in_cents, Float, null: false
    field :average_price_currency, Types::Enums::CurrencyType, null: true
    field :quantity, Float, null: false
    field :asset_symbol_id, Integer, null: false
    field :asset_symbol, Types::AssetSymbolType, null: false
    field :quantity_in_brokers, GraphQL::Types::JSON, null: true
    # field :other, Types::JsonbType, null: true
    field :lock_version, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def asset_symbol
      RecordLoader.for(AssetSymbol).load(object.asset_symbol_id)
    end
  end
end
