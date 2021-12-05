module AssetSymbols
  # Обновляет последнюю цену для тикера
  # @note Пока что работает только для US тикеров!! Так как Finnhub только для Enterprise аккаунтов эту инфу дает
  class UpdateAssetSymbolLastPrice < BaseInteractor
    class Contract < BaseContract
      params do
        required(:asset_symbol).filled(type?: AssetSymbol)
      end
    end

    include Dry::Transaction

    validate_input contract: Contract
    step :request_quote_for_asset
    map :set_attributes_for_asset
    step :save_asset_symbol

    private

    def request_quote_for_asset(input)
      quote_hash = quote(input[:asset_symbol])
      if quote_hash.present?
        input[:quote] = quote_hash
        Success(input)
      else
        # TODO: logging, retry, etc.
        Failure(:api_error)
      end
    end

    def set_attributes_for_asset(input)
      asset_symbol = input[:asset_symbol]
      # TODO: move logic to currency collection
      asset_symbol.currency = asset_symbol.from_moscow_exchange? ? "RUB" : "USD"
      asset_symbol.last_price_in_cents = current_price_in_cents_from_quote(input[:quote])
      input.merge(asset_symbol: asset_symbol)
    end

    def save_asset_symbol(input)
      input[:asset_symbol].save!
      Success(input[:asset_symbol])
    rescue => e
      Failure(e)
    end

    def quote(asset_symbol)
      @quote ||= FinnhubConfig.api.quote(asset_symbol.symbol)
    end

    def current_price_in_cents_from_quote(quote)
      price = quote.c * 100
      price.to_i
    end
  end
end
