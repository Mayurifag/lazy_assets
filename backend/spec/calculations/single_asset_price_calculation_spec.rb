require "rails_helper"
require "dry/monads"

RSpec.describe SingleAssetPriceCalculation, type: :calculation do
  include Dry::Monads[:result]
  subject { described_class.call(params) }

  let(:params) do
    {
      total_price_in_cents: total_price_in_cents,
      quantity: quantity
    }
  end

  context "when params are wrong" do
    context "when params are empty" do
      let(:params) { {} }

      it { is_expected.to eq Failure({errors: {total_price_in_cents: ["is missing"], quantity: ["is missing"]}}) }
    end

    context "when quantity is wrong" do
      let(:total_price_in_cents) { 111 }
      let(:quantity) { 0 }

      it { is_expected.to eq Failure({total_price_in_cents: 111, quantity: 0, errors: {quantity: ["must be greater than 0"]}}) }
    end

    context "when both params wrong" do
      let(:total_price_in_cents) { -1 }
      let(:quantity) { 0 }

      it { is_expected.to eq Failure({total_price_in_cents: -1, quantity: 0, errors: {total_price_in_cents: ["must be greater than or equal to 0"], quantity: ["must be greater than 0"]}}) }
    end

    context "when total_price_in_cents wrong" do
      let(:total_price_in_cents) { -1 }
      let(:quantity) { 5 }

      it { is_expected.to eq Failure({total_price_in_cents: -1, quantity: 5, errors: {total_price_in_cents: ["must be greater than or equal to 0"]}}) }
    end
  end

  context "when params are truthy" do
    context "when total price is 0" do
      let(:total_price_in_cents) { 0 }
      let(:quantity) { 5 }

      it { is_expected.to eq Success(0.0) }
    end

    context "when total price is 7758 and quantity is 809" do
      let(:total_price_in_cents) { 7758 }
      let(:quantity) { 809 }

      it { is_expected.to eq Success(0.095896) }
    end
  end
end
