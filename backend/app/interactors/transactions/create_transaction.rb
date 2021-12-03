module Transactions
  # TODO: для продажи действие и др.
  class CreateTransaction < BaseInteractor
    class Contract < BaseContract
      params do
        required(:action).filled(included_in?: Transaction.actions.keys)
        required(:date).filled(:date) # TODO: 2000-01-01 < date < Date.tomorrow
        required(:currency).filled(included_in?: CurrencyCollection.all) # TODO: finded asset currency equals that
        optional(:accured_interest_in_cents).filled(:integer) # TODO: gteq 0
        required(:total_price_in_cents).filled(:integer) # TODO: gteq 0
        required(:quantity).filled(:decimal) # TODO: gt 0
        optional(:total_price_commission_in_cents).filled(:integer) # TODO: gteq 0
        required(:asset_symbol).filled(type?: AssetSymbol)
        required(:broker).filled(type?: Broker)
      end
    end

    include Dry::Transaction(container: BaseContainer)

    around :transaction, with: "transaction"

    validate_input contract: Contract
    step :calculate_price_for_one_asset
    step :create_or_update_asset
    step :save_transaction

    private

    def calculate_price_for_one_asset(input)
      params = {
        total_price_in_cents: input[:total_price_in_cents],
        quantity: input[:quantity]
      }
      calc = SingleAssetPriceCalculation.call(params)

      if calc.success?
        Success(input.merge(price_for_one_asset_in_cents: calc.success))
      else
        Failure(errors: calc.failure[:errors])
      end
    end

    def create_or_update_asset(input)
      params = {
        currency: input[:currency],
        add_price_in_cents: input[:price_for_one_asset_in_cents],
        add_quantity: input[:quantity],
        asset_symbol: input[:asset_symbol],
        broker: input[:broker]
      }

      asset_interactor = Assets::CreateOrUpdateAsset.call(params)

      if asset_interactor.success?
        Success(input.merge(asset: asset_interactor.success))
      else
        Failure(errors: asset_interactor.failure[:errors])
      end
    end

    def save_transaction(input)
      transaction = Transaction.new(input)
      transaction.save!
      Success(transaction: transaction)
    rescue => e
      Failure(e)
    end
  end
end
