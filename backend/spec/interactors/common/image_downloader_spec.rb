require "rails_helper"

RSpec.describe Common::ImageDownloader, type: :interactor do
  let_it_be(:exchange) { create :exchange }
  let_it_be(:object) do
    create :asset_symbol,
      exchange: exchange,
      symbol: "GMKN.ME",
      original_logo_url: "https://finnhub.io/api/logo?symbol=GMKN.ME"
  end

  subject do
    VCR.use_cassette("interactors/common/image_downloader__200") do
      described_class.call(
        attachable_object: object.logo,
        image_url: object.original_logo_url,
        filename: "#{object.symbol}-logo"
      )
    end
  end

  describe "#call" do
    context "when supposed to be successful" do
      it { is_expected.to be_success }

      it "attaches pic to asset symbol" do
        expect { subject }.to change { ActiveStorage::Attachment.count }.from(0).to(1)
      end
    end

    context "when supposed to be failure" do
      context "when pic didnt download" do
        before { allow(Down).to receive(:download).and_raise(Down::Error) }

        it { is_expected.to be_failure }
        it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
      end

      context "when pic wasnt able to attach" do
        before { allow(object.logo).to receive(:attach).and_raise(StandardError) }

        it { is_expected.to be_failure }
        it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
      end
    end
  end
end
