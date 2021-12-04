require "rails_helper"

RSpec.describe Types::QueryType do
  subject(:result) do
    ApiSchema.execute(query).as_json
  end

  let_it_be(:exchange) { create :exchange, name: "asd" }
  let_it_be(:asset_symbol) { create :asset_symbol, exchange: exchange }
  let_it_be(:asset) { create :asset, asset_symbol: asset_symbol }
  let_it_be(:broker) { create :broker }

  describe "transactions" do
    let!(:transactions) { create_pair(:transaction, broker: broker, asset: asset, asset_symbol: asset_symbol) }
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

    it "returns correctly answers with array of Transaction's hashes" do
      expect(result.dig("data", "transactions", 0, "assetSymbol", "exchange", "name")).to eq asset_symbol.exchange.name
      expect(result.dig("data", "transactions", 0, "asset", "quantity")).to eq asset.quantity
      expect(result.dig("data", "transactions", 1, "broker", "name")).to eq broker.name
    end
  end

  describe "assets" do
    let(:query) do
      %(
        query GetAssets {
          assets {
            quantity
            averagePriceInCents
            averagePriceCurrency
            assetSymbol {
              nameRu
              symbol
              exchange {
                name
              }
            }
          }
        }
      )
    end

    it "returns correctly answers with array of assets's hashes" do
      expect(result.dig("data", "assets", 0, "assetSymbol", "exchange", "name")).to eq asset.asset_symbol.exchange.name
      expect(result.dig("data", "assets", 0, "assetSymbol", "symbol")).to eq asset.asset_symbol.symbol
      expect(result.dig("data", "assets", 0, "quantity")).to eq asset.quantity
    end
  end
end
