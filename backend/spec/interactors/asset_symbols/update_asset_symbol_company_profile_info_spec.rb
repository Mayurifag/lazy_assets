require "rails_helper"

RSpec.describe AssetSymbols::UpdateAssetSymbolCompanyProfileInfo, type: :interactor do
  let_it_be(:asset_symbol) { create :asset_symbol, :with_exchange, symbol: "GMKN.ME" }

  describe "#call" do
    context "when request is successful" do
      subject do
        VCR.use_cassette("interactors/asset_symbols/update_asset_symbol_company_profile_info__200") do
          described_class.call(asset_symbol: asset_symbol)
        end
      end

      it { is_expected.to be_success }

      it do
        expect { subject }
          .to change { asset_symbol.country }.from(nil).to("RU")
          .and change { asset_symbol.original_logo_url }.from(nil)
          .and change { asset_symbol.sector_id }.from(nil)
          .and change { Sector.count }.from(0).to(1)
      end

      context "when cant be saved into db" do
        before { allow_any_instance_of(AssetSymbol).to receive(:save!).and_raise(ActiveRecord::RecordInvalid) }

        it { is_expected.to be_failure }
        it { expect { subject }.not_to change { asset_symbol } }
      end
    end

    context "when request failed" do
      subject do
        allow_any_instance_of(FinnhubRuby::DefaultApi).to receive(:company_profile2).and_return([])
        described_class.call(asset_symbol: asset_symbol)
      end

      it { is_expected.to be_failure }
      it { expect { subject }.not_to change { asset_symbol } }
    end
  end
end
