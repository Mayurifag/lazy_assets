require "rails_helper"

RSpec.describe Types::QueryType do
  let_it_be(:asset_symbol) { create :asset_symbol, :with_exchange }
  let_it_be(:asset) do
    create :asset, asset_symbol: asset_symbol
  end
  let_it_be(:broker) { create :broker }
  let_it_be(:transactions) { create_pair(:transaction, broker: broker, asset: asset) }

  describe "transactions" do
    let(:query) do
      %(query {
        transactions {
          currency
        }
      })
    end

    subject(:result) do
      LazyAssetsSchema.execute(query).as_json
    end

    it "returns all currencies" do
      expect(result.dig("data", "transactions")).to match_array(
        transactions.map { |transaction| {"currency" => transaction.currency} }
      )
    end
  end
end
