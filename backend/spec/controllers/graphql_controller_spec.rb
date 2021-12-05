require "rails_helper"

RSpec.describe GraphqlController, type: :controller do
  context "when query will be success" do
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

    context "when no data for query" do
      it do
        graphql_raw_post(raw: query, variables: {})

        expect(response.status).to eq(200)
        expect(graphql_data["assets"]).to eq([])
      end
    end

    context "when there are some data for query" do
      let!(:exchange) { create :exchange, name: "asd" }
      let!(:asset_symbol) { create :asset_symbol, exchange: exchange }
      let!(:asset) { create :asset, asset_symbol: asset_symbol }

      it do
        graphql_raw_post(raw: query, variables: {})

        expect(response.status).to eq(200)
        expect(graphql_data["assets"][0].keys).to match_array(["quantity", "averagePriceInCents", "averagePriceCurrency", "assetSymbol"])
      end
    end
  end
end
