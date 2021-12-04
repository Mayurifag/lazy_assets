class AssetSymbol < ApplicationRecord
  belongs_to :exchange

  named_enum :currency, CurrencyCollection.codes

  def from_moscow_exchange?
    exchange.moscow?
  end
end
