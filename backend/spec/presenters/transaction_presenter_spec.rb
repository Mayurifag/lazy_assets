require "rails_helper"

RSpec.describe TransactionPresenter, type: :presenter do
  describe "#total_price_presented" do
    subject { transaction.total_price_presented }

    context "when total price equals 1 USD" do
      let(:transaction) { build :transaction, total_price_in_cents: 100, currency: "USD" }

      it { is_expected.to eq "$1.00" }
    end
  end

  describe "#total_price_commission_presented" do
    subject { transaction.total_price_commission_presented }

    context "when total price commission equals 1 USD" do
      let(:transaction) { build :transaction, total_price_commission_in_cents: 100, currency: "USD" }

      it { is_expected.to eq "$1.00" }
    end

    context "when total price commission equals 0 USD" do
      let(:transaction) { build :transaction, total_price_commission_in_cents: 0, currency: "USD" }

      it { is_expected.to eq "-" }
    end
  end

  describe "#accured_interest_presented" do
    subject { transaction.accured_interest_presented }

    context "when accured interest equals 1 USD" do
      let(:transaction) { build :transaction, accured_interest_in_cents: 100, currency: "USD" }

      it { is_expected.to eq "$1.00" }
    end

    context "when total price commission equals 0 USD" do
      let(:transaction) { build :transaction, accured_interest_in_cents: 0, currency: "USD" }

      it { is_expected.to eq "-" }
    end
  end

  describe "#price_for_one_asset_presented" do
    subject { transaction.price_for_one_asset_presented }

    context "when price for single asset equals 1 USD" do
      let(:transaction) { build :transaction, price_for_one_asset_in_cents: 100, currency: "USD" }

      it { is_expected.to eq "$1.00" }
    end

    context "when total price commission equals 0 USD" do
      let(:transaction) { build :transaction, price_for_one_asset_in_cents: 0, currency: "USD" }

      it { is_expected.to eq "-" }
    end
  end
end
