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
  translate_enum :action
end
