require "rails_helper"

RSpec.describe AssetSymbols::UpdateAssetSymbolLastPrice, type: :interactor do
  let(:exchange) { create :exchange, mic: "ASDF" }
  let!(:asset_symbol) { create :asset_symbol, exchange: exchange, symbol: "AAPL" }

  describe "#call" do
    context "when request is successful" do
      subject do
        VCR.use_cassette("interactors/asset_symbols/update_asset_symbol_last_price__200") do
          described_class.call(asset_symbol: asset_symbol)
        end
      end

      it { is_expected.to be_success }

      it "adds values to db skipping not needed ones (test data and so on)" do
        expect { subject }
          .to change { asset_symbol.currency }.from(nil).to("USD")
          .and change { asset_symbol.last_price_in_cents }.from(nil)
      end

      context "when requested stock from moscow exchange" do
        let(:exchange) { create :exchange, mic: "MISX" }

        it { is_expected.to be_success }

        it "adds values to db skipping not needed ones (test data and so on)" do
          expect { subject }
            .to change { asset_symbol.currency }.from(nil).to("RUB")
            .and change { asset_symbol.last_price_in_cents }.from(nil)
        end
      end

      context "when cant be saved into db" do
        before { allow_any_instance_of(AssetSymbol).to receive(:save!).and_raise(ActiveRecord::RecordInvalid) }

        it { is_expected.to be_failure }
        it { expect { subject }.not_to change { asset_symbol } }
      end
    end

    context "when request failed" do
      subject do
        allow_any_instance_of(FinnhubRuby::DefaultApi).to receive(:quote).and_return([])
        described_class.call(asset_symbol: asset_symbol)
      end

      it { is_expected.to be_failure }
      it { expect { subject }.not_to change { asset_symbol } }
    end
  end
end
