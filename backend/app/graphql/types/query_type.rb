module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :transactions,
      [Types::TransactionType],
      null: false,
      description: "Returns a list of transactions"

    def transactions
      Transaction.all
    end
  end
end
