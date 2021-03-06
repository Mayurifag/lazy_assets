module Types
  class TransactionType < Types::BaseObject
    field :id, ID, null: false
    field :action, String, null: true
    field :asset_id, Integer, null: false
    field :asset, Types::AssetType, null: false
    field :asset_symbol_id, Integer, null: false
    field :asset_symbol, Types::AssetSymbolType, null: false
    field :broker_id, Integer, null: false
    field :broker, Types::BrokerType, null: false
    field :quantity, Float, null: false
    field :price_for_one_asset_in_cents, Float, null: false
    field :total_price_in_cents, Integer, null: false
    field :total_price_commission_in_cents, Integer, null: false
    field :accured_interest_in_cents, Integer, null: true
    field :currency, Types::Enums::CurrencyType, null: false
    field :date, GraphQL::Types::ISO8601Date, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :total_price_presented, String, null: false
    field :total_price_commission_presented, String, null: false
    field :accured_interest_presented, String, null: false
    field :price_for_one_asset_presented, String, null: false

    def asset
      RecordLoader.for(Asset).load(object.asset_id)
    end

    def broker
      RecordLoader.for(Broker).load(object.broker_id)
    end

    def asset_symbol
      RecordLoader.for(AssetSymbol).load(object.asset_symbol_id)
    end
  end
end
