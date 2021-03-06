class Transaction < ApplicationRecord
  include TransactionPresenter

  belongs_to :asset
  belongs_to :broker
  belongs_to :asset_symbol

  named_enum :action, %w[
    buy
    sell
    commission
    convertation
    dividend
    income
    other
  ], _suffix: true
  # TODO: i18n
  translate_enum :action

  named_enum :currency, CurrencyCollection.codes
end
