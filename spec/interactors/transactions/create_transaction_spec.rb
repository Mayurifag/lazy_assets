require "rails_helper"
require "dry/monads"

RSpec.describe Transactions::CreateTransaction, type: :interactor do
  include Dry::Monads[:result]

  let_it_be(:asset_symbol) { create :asset_symbol, :with_exchange }
  let_it_be(:broker) { create :broker }
  let_it_be(:another_broker) { create :broker }
  let(:date) { "2020-10-02".to_date }
  let(:currency) { "RUB" }
  let(:total_price_in_cents) { 123_00 }
  let(:quantity) { 5 }
  let(:params) do
    {
      action: action,
      date: date,
      currency: currency,
      total_price_in_cents: total_price_in_cents,
      quantity: quantity,
      asset_symbol: asset_symbol,
      broker: broker
    }
  end

  subject { described_class.call(params) }

  context "when action is buy" do
    let(:action) { "buy" }

    it { is_expected.to be_success }

    it "adds transaction, counts total price, etc." do
      expect { subject }
        .to change { Transaction.count }.from(0).to(1)
        .and change { Asset.count }.from(0).to(1)
        .and change { Transaction.first&.currency }.to("RUB")
        .and change { Transaction.first&.price_for_one_asset_in_cents }.to(24.6)
        .and change { Transaction.first&.date }.to(date)
    end

    context "when single price calculation service returned failure" do
      before do
        allow_any_instance_of(SingleAssetPriceCalculation)
          .to receive(:call).and_return(Failure({}))
      end

      it { is_expected.to be_failure }

      it "adds transaction, counts total price, etc." do
        expect { subject }
          .to not_change { Transaction.count }.from(0)
          .and not_change { Asset.count }.from(0)
      end
    end

    context "when Assets::CreateOrUpdateAsset service returned failure" do
      before do
        allow_any_instance_of(Assets::CreateOrUpdateAsset)
          .to receive(:call).and_return(Failure({}))
      end

      it { is_expected.to be_failure }

      it "adds transaction, counts total price, etc." do
        expect { subject }
          .to not_change { Transaction.count }.from(0)
          .and not_change { Asset.count }.from(0)
      end
    end

    context "when Transaction wasnt able to save" do
      before do
        allow_any_instance_of(Transaction)
          .to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
      end

      it { is_expected.to be_failure }

      it "adds transaction, counts total price, etc." do
        expect { subject }
          .to not_change { Transaction.count }.from(0)
          .and not_change { Asset.count }.from(0)
      end
    end
  end

  xcontext "when action is sell should decrease quantity" do
    let(:action) { "sell" }
  end
end
