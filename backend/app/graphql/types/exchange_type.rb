module Types
  class ExchangeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :country, String, null: true
    field :mic, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
