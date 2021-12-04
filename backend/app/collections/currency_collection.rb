class CurrencyCollection < BaseCollection
  CURRENCY_COLLECTION = {
    "USD" => "The United States dollar (symbol: $)",
    "RUB" => "The Russian ruble or rouble (symbol: ₽)"
  }

  # @returns Array<String>
  def codes
    @codes ||= CURRENCY_COLLECTION.keys
  end

  # @returns Hash<String<String>>
  def codes_with_description
    CURRENCY_COLLECTION
  end
end
