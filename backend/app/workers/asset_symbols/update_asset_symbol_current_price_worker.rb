class AssetSymbols::UpdateAssetSymbolCurrentPriceWorker
  include Sidekiq::Worker

  def perform(ticker_symbol_string)
    asset_symbol = AssetSymbol.find_by(symbol: ticker_symbol_string)
    if asset_symbol.present?

      puts "UpdateAssetSymbolCurrentPriceWorker: processing #{ticker_symbol_string}"
      AssetSymbols::UpdateAssetSymbolLastPrice.call(asset_symbol: asset_symbol)
    end
  end
end
