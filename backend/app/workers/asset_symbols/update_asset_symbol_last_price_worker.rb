class AssetSymbols::UpdateAssetSymbolLastPriceWorker
  include Sidekiq::Worker

  def perform(ticker_symbol_string)
    asset_symbol = AssetSymbol.find_by(symbol: ticker_symbol_string)
    if asset_symbol.present?
      # TODO: make logging, thats ok for docker and test environment
      ::AssetSymbols::UpdateAssetSymbolLastPrice.call(asset_symbol: asset_symbol)
    end
  end
end
