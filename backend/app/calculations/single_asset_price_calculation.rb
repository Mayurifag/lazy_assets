class SingleAssetPriceCalculation < BaseCalculation
  class Contract < BaseContract
    params do
      required(:total_price_in_cents) { gteq?(0) & int? }
      required(:quantity) { gt?(0) }
    end
  end

  include Dry::Transaction

  validate_input contract: Contract
  map :calculate_price_for_one_asset

  private

  def calculate_price_for_one_asset(input)
    total = input[:total_price_in_cents].to_d
    quantity = input[:quantity].to_d
    result = total / 100 / quantity
    result.round(6)
  end
end
