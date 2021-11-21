module Types
  class AssetType < Types::BaseObject
    field :id, ID, null: false
    field :average_price_in_cents, Float, null: false
    field :average_price_currency, String, null: true
    field :quantity, Float, null: false
    # TODO: make loading this
    field :asset_symbol_id, Integer, null: false
    # field :quantity_in_brokers, Types::JsonbType, null: true
    # field :other, Types::JsonbType, null: true
    field :lock_version, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
