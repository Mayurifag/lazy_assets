require "rails_helper"

RSpec.describe Types::QueryType do
  let_it_be(:asset_symbol) { create :asset_symbol, :with_exchange }
  let_it_be(:asset) do
    create :asset, asset_symbol: asset_symbol
  end
  let_it_be(:broker) { create :broker }
  let_it_be(:transactions) { create_pair(:transaction, broker: broker, asset: asset, asset_symbol: asset_symbol) }

  describe "transactions" do
    let(:query) do
      %(
        query GetTransactions {
          transactions {
            action
            id
            assetSymbol {
              nameEn
              symbol
              exchange {
                name
              }
            }
            asset {
              quantity
            }
            broker {
              name
            }
            quantity
            priceForOneAssetInCents
            accuredInterestInCents
            currency
            date
            totalPricePresented
            totalPriceCommissionPresented
            priceForOneAssetPresented
            accuredInterestPresented
          }
        }
      )
    end

    subject(:result) do
      ApiSchema.execute(query).as_json
    end

    it "returns correctly answers with array of Transaction's hashes" do
      expect(result.dig("data", "transactions", 0, "assetSymbol", "exchange", "name")).to eq asset_symbol.exchange.name
      expect(result.dig("data", "transactions", 0, "asset", "quantity")).to eq asset.quantity
      expect(result.dig("data", "transactions", 1, "broker", "name")).to eq broker.name
    end
  end
end
