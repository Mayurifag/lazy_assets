require "rails_helper"

RSpec.describe AssetSymbols::PopulateUsSymbols, type: :interactor do
  before_all { create :exchange, :ootc }

  describe "#call" do
    context "when request is successful" do
      subject do
        VCR.use_cassette("interactors/asset_symbols/populate_us_symbols__200") do
          described_class.call
        end
      end

      it { is_expected.to be_success }

      it "adds values to db skipping not needed ones (test data and so on)" do
        expect { subject }
          .to change { AssetSymbol.count }.from(0).to(1)
          .and not_change { AssetSymbol.where(symbol: "ZXIET").count }
          .and change { AssetSymbol.first&.exchange&.mic }.to eq("OOTC")
      end

      context "when AssetSymbol.upsert_all failed" do
        before { allow(AssetSymbol).to receive(:upsert_all).and_raise(ActiveRecord::RecordInvalid) }

        it { is_expected.to be_failure }
        it { expect { subject }.not_to change { AssetSymbol.count }.from(0) }
      end
    end

    context "when request failed" do
      subject do
        allow_any_instance_of(FinnhubRuby::DefaultApi).to receive(:stock_symbols).and_return([])
        described_class.call
      end

      it { is_expected.to be_failure }
      it { expect { subject }.not_to change { AssetSymbol.count }.from(0) }
    end
  end
end
