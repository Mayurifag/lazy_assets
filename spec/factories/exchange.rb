FactoryBot.define do
  factory :exchange do
    name { "exchange" }
    country { "russia" }
    mic { "ASDF" }

    trait :misx do
      name { "Moscow Stock Exchange" }
      country { "Russia" }
      mic { "MISX" }
    end

    trait :ootc do
      name { "Other OTC" }
      country { "US" }
      mic { "OOTC" }
    end
  end
end
