class Transaction < ApplicationRecord
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

  named_enum :currency, CurrencyCollection.all
end