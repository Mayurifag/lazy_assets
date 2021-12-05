module Common
  # Downloads image from URL and stores it into active storage
  # @example
  #   Common::ImageDownloader.call(attachable_object: AssetSymbol.find_by(symbol: "GMKN.ME").logo, image_url: "https://finnhub.io/api/logo?symbol=GMKN.ME", filename: "GMKN.ME-logo")
  # TODO: add spec
  class ImageDownloader < BaseInteractor
    class Contract < BaseContract
      params do
        required(:attachable_object) # TODO: validation - findable + responds to ...
        required(:image_url).filled(:string) # TODO: validation - is valid url
        required(:filename).filled(:string)
      end
    end

    include Dry::Transaction

    validate_input contract: Contract
    step :download_and_optimize_image
    step :attach_image_to_object

    private

    def download_and_optimize_image(input)
      image = Down.download(input[:image_url], max_size: 5 * 1024 * 1024) # 5 MB
      processed = ImageProcessing::Vips
        .source(image)
        .resize_to_fit(100, 100)
        .convert("jpg")
        .saver(quality: 90, strip: true)
        .call

      Success(input.merge(image: processed))
    rescue => e
      Failure(msg: "Image wasn't able to be downloaded", error: e)
    ensure
      image.close
      image.unlink
    end

    def attach_image_to_object(input)
      input[:attachable_object].attach(io: File.open(input[:image].path), filename: input[:filename])
      Success(input)
    rescue => e
      Failure(msg: "Image attach transaction failured", error: e)
    ensure
      input[:image].close
      input[:image].unlink
    end
  end
end
