FactoryBot.define do
  factory :asset_symbol do
    name_en { Faker::App.author }
    symbol { Faker::App.name }
    last_source { "factory" }

    trait :with_exchange do
      exchange
    end
  end
end
