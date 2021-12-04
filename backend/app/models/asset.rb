class Asset < ApplicationRecord
  belongs_to :asset_symbol

  named_enum :average_price_currency, CurrencyCollection.codes
end
