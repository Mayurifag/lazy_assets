module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: move
    # https://www.digitalocean.com/community/tutorials/how-to-set-up-a-ruby-on-rails-graphql-api

    field :transactions, [Types::TransactionType], description: "Returns a list of transactions"
    def transactions
      Transaction.all
    end

    field :assets, [Types::AssetType], description: "Returns a list of assets"
    def assets
      Asset.all
    end
  end
end
