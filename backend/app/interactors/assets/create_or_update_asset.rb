module Assets
  class CreateOrUpdateAsset < BaseInteractor
    class Contract < BaseContract
      params do
        required(:currency).filled(included_in?: CurrencyCollection.codes) # TODO: finded asset currency equals that
        required(:add_price_in_cents).filled(:integer) # TODO: gteq 0
        required(:add_quantity).filled(:decimal) # TODO: gt 0
        required(:asset_symbol).filled(type?: AssetSymbol)
        required(:broker).filled(type?: Broker)
      end
    end

    include Dry::Transaction

    validate_input contract: Contract
    map :find_or_initialize_asset
    map :calculate_attributes
    step :save_asset

    private

    def find_or_initialize_asset(input)
      asset = Asset.find_or_initialize_by(asset_symbol: input[:asset_symbol])
      asset.average_price_currency = input[:currency]
      input.merge(asset: asset)
    end

    def calculate_attributes(input)
      input[:asset] =
        if input[:asset].persisted?
          calculate_attributes_for_persisted_asset(input)
        else
          calculate_attributes_for_new_asset(input)
        end
      input
    end

    def calculate_attributes_for_persisted_asset(input)
      asset = input[:asset]
      params = {
        old_price: asset.average_price_in_cents,
        old_quantity: asset.quantity,
        add_price: input[:add_price_in_cents],
        add_quantity: input[:add_quantity]
      }
      prev_broker_quantity = asset.quantity_in_brokers[input[:broker].name].to_d

      asset.average_price_in_cents = NewAveragePriceCalculation.call(params).success
      asset.quantity = asset.quantity + input[:add_quantity]
      asset.quantity_in_brokers[input[:broker].name] = prev_broker_quantity + input[:add_quantity]
      asset
    end

    def calculate_attributes_for_new_asset(input)
      asset = input[:asset]
      asset.average_price_in_cents = input[:add_price_in_cents]
      asset.quantity = input[:add_quantity]
      asset.quantity_in_brokers = Hash.new(0)
      asset.quantity_in_brokers[input[:broker].name] = input[:add_quantity]
      asset
    end

    def save_asset(input)
      input[:asset].save!
      Success(input[:asset])
    rescue => e
      Failure(e)
    end
  end
end
