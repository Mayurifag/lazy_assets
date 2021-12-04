module Types
  module Enums
    class CurrencyType < BaseEnum
      CurrencyCollection.codes_with_description.each do |code, description|
        value code, description: description
      end
    end
  end
end
