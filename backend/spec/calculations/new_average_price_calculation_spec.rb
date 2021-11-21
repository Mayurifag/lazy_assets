require "rails_helper"
require "dry/monads"

RSpec.describe NewAveragePriceCalculation, type: :calculation do
  include Dry::Monads[:result]
  subject { described_class.call(params) }

  let(:params) do
    {
      old_price: old_price,
      add_price: add_price,
      add_quantity: add_quantity,
      old_quantity: old_quantity
    }
  end

  context "when params are wrong" do
    context "when params are empty" do
      let(:params) { {} }

      it { is_expected.to eq Failure({errors: {old_price: ["is missing"], old_quantity: ["is missing"], add_price: ["is missing"], add_quantity: ["is missing"]}}) }
    end
  end

  context "when params are truthy" do
    context "when old price/quantity were 50/10 and we add 100/1" do
      let(:old_price) { 50 }
      let(:old_quantity) { 10 }
      let(:add_price) { 100 }
      let(:add_quantity) { 1 }

      it { is_expected.to eq Success(54.545455) }
    end

    context "when old price/quantity were 220.3/1 and we add 206.92/1" do
      let(:old_price) { 22030 }
      let(:old_quantity) { 1 }
      let(:add_price) { 20692 }
      let(:add_quantity) { 1 }

      it { is_expected.to eq Success(21361) }
    end
  end
end
