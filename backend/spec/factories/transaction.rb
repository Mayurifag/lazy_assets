FactoryBot.define do
  factory :transaction do
    action { "buy" }
    quantity { 1 }
    price_for_one_asset_in_cents { 100 }
    total_price_in_cents { 100 }
    total_price_commission_in_cents { 1 }
    currency { "USD" }
    date { "2021-11-07" }

    trait :with_asset do
      asset
    end

    trait :with_broker do
      broker
    end

    trait :with_asset_symbol do
      asset_symbol
    end
  end
end
