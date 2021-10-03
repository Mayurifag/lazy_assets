FactoryBot.define do
  factory :asset do
    average_price_in_cents { 100_00 }
    average_price_currency { "RUB" }
    quantity { 1.0 }
    quantity_in_brokers do
      {
        Tinkoff: 1.0
      }
    end

    trait :with_asset_symbol do
      asset_symbol
    end
  end
end
