class CurrencyCollection < BaseCollection
  CURRENCY_COLLECTION = %w[USD RUB]

  def all
    CURRENCY_COLLECTION
  end
end
