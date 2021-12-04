class AssetSymbol < ApplicationRecord
  belongs_to :exchange

  def from_moscow_exchange?
    exchange.moscow?
  end
end
