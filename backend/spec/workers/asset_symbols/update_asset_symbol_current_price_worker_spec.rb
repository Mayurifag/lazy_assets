require "rails_helper"

RSpec.describe AssetSymbols::UpdateAssetSymbolCurrentPriceWorker, type: :worker do
  let_it_be(:asset_symbol) { create :asset_symbol, :with_exchange, symbol: "AAPL" }

  describe "perform_async" do
    subject do
      VCR.use_cassette("interactors/asset_symbols/update_asset_symbol_current_price_worker__200") do
        Sidekiq::Testing.inline! do
          described_class.perform_async(ticker_symbol)
        end
      end
    end

    context "when no asset symbol with such ticker symbol" do
      let(:ticker_symbol) { "doesnt_exist_in_db" }

      it "doesnt call AssetSymbols::UpdateAssetSymbolLastPrice" do
        expect(AssetSymbols::UpdateAssetSymbolLastPrice).not_to receive(:call)
        subject
      end
    end

    context "when exists asset symbol with such ticker symbol" do
      let(:ticker_symbol) { asset_symbol.symbol }

      it "calls AssetSymbols::UpdateAssetSymbolLastPrice once" do
        expect(AssetSymbols::UpdateAssetSymbolLastPrice).to receive(:call).with(asset_symbol: asset_symbol).and_return(double(call: true)).once
        subject
      end
    end
  end
end
