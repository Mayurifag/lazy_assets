module Transactions
  class CreateTransaction < BaseInteractor
    class Contract < BaseContract
      params do
        required(:action).filled(included_in?: Transaction.actions.keys)
        required(:date).filled(:date) # TODO: 2000-01-01 < date < Date.tomorrow
        required(:currency).filled(included_in?: %w[USD RUB])
        optional(:accured_interest_in_cents).filled(:integer)
        required(:price_in_cents).filled(:integer)
        required(:quantity).filled(:float)
        optional(:price_commission_in_cents).filled(:integer)
        required(:asset_symbol).filled(type?: AssetSymbol)
      end
    end

    include Dry::Transaction(container: MyContainer)

    around :transaction, with: "transaction"

    validate_input contract: Contract
    step :calculate_total_price
    step :save_transaction
    tee :publish_event
  end
end
