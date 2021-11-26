module Types
  class AssetSymbolType < Types::BaseObject
    field :id, ID, null: false
    field :name_ru, String, null: true
    field :name_en, String, null: true
    field :exchange_id, Integer, null: false
    field :exchange, Types::ExchangeType, null: false
    field :symbol, String, null: true
    field :last_source, String, null: true
    # field :last_source_initial_attributes, Types::JsonbType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def exchange
      RecordLoader.for(Exchange).load(object.exchange_id)
    end
  end
end
