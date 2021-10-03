# Thinking of params = [quantity: price, quantity: price, quantity: price, ...]
# https://ihakimov.ru/calcmid/
class NewAveragePriceCalculation < BaseCalculation
  class Contract < BaseContract
    params do
      required(:old_price) { gteq?(0) }
      required(:old_quantity) { gt?(0) }
      required(:add_price) { gteq?(0) }
      required(:add_quantity) { gt?(0) }
    end
  end

  include Dry::Transaction

  validate_input contract: Contract
  map :calculate_new_avg_price

  private

  def calculate_new_avg_price(input)
    price1 = input[:old_price].to_d
    quantity1 = input[:old_quantity].to_d
    price2 = input[:add_price].to_d
    quantity2 = input[:add_quantity].to_d

    result = (price1 * quantity1 + price2 * quantity2) / (quantity1 + quantity2)
    result.round(6)
  end
end
