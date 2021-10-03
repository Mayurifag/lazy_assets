require "rails_helper"

RSpec.describe Assets::CreateOrUpdateAsset, type: :interactor do
  let_it_be(:asset_symbol) { create :asset_symbol, :with_exchange }
  let_it_be(:broker) { create :broker }
  let_it_be(:another_broker) { create :broker }
  let(:currency) { "RUB" }
  let(:add_price_in_cents) { 123_00 }
  let(:add_quantity) { 5 }
  let(:params) do
    {
      currency: currency,
      add_price_in_cents: add_price_in_cents,
      add_quantity: add_quantity,
      asset_symbol: asset_symbol,
      broker: broker
    }
  end

  subject { described_class.call(params) }

  context "when params are valid" do
    context "when there is no asset with same asset_symbol" do
      it { is_expected.to be_success }

      it "creates new asset" do
        expect { subject }
          .to change { Asset.count }.from(0).to(1)
      end

      context "when service called 2 times in a row" do
        subject { 2.times { described_class.call(params) } }

        it "creates single asset and updates it" do
          expect { subject }
            .to change { Asset.count }.from(0).to(1)
            .and change { Asset.take&.quantity }.to(10)
            .and change { Asset.take&.quantity_in_brokers&.fetch(broker.name) }.to("10.0")
        end
      end

      context "when cant be saved into db" do
        before { allow_any_instance_of(Asset).to receive(:save!).and_raise(ActiveRecord::RecordInvalid) }

        it { is_expected.to be_failure }
        it { expect { subject }.not_to change { Asset.count }.from(0) }
      end
    end

    context "when there is asset with same asset_symbol" do
      let!(:asset) do
        create :asset, asset_symbol: asset_symbol,
                       quantity: 2,
                       average_price_in_cents: 100,
                       average_price_currency: currency,
                       quantity_in_brokers: {
                         "#{broker.name}": "1.0",
                         "#{another_broker.name}": "1"
                       }
      end

      it { is_expected.to be_success }

      it "updates existing asset" do
        expect { subject }
          .to not_change { Asset.count }.from(1)
          .and change { Asset.take.quantity }.from(2).to(7)
          .and change { Asset.take.average_price_in_cents }.from(100).to(8814.285714)
          .and not_change { Asset.take.average_price_currency }.from("RUB")
          .and change { Asset.take.quantity_in_brokers[broker.name] }.from("1.0").to("6.0")
          .and not_change { Asset.take.quantity_in_brokers[another_broker.name] }.from("1")
      end
    end
  end
end
