class AssetSymbol < ApplicationRecord
  has_one_attached :logo

  belongs_to :exchange
  belongs_to :sector, optional: true

  named_enum :currency, CurrencyCollection.codes

  def from_moscow_exchange?
    exchange.moscow?
  end
end
