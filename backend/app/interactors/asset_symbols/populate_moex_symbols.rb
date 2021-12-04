module AssetSymbols
  # Идемпотентно пополняет AssetSymbols тикерами с Московской Биржи,
  # исключая иностранные тикеры, которые берутся с US бирж
  class PopulateMoexSymbols < BaseInteractor
    include Dry::Transaction

    MOEX_FINNHUB_EXCHANGE_SYMBOL = "ME"
    private_constant :MOEX_FINNHUB_EXCHANGE_SYMBOL

    step :request_me_stocks
    map :filter_non_moex_stocks
    map :make_attributes_for_upsert_all
    step :create_or_update_moex_assets_symbols

    private

    def request_me_stocks
      if data_from_made_request.present?
        Success(data: data_from_made_request)
      else
        # TODO: logging, retry, etc.
        Failure(:api_error)
      end
    end

    def filter_non_moex_stocks(input)
      input[:data].delete_if do |stock_row|
        stock_row.display_symbol.end_with?("-RM.ME")
      end
    end

    def make_attributes_for_upsert_all(input)
      exchange_id = Exchange.find_by(mic: "MISX").id
      time_now = Time.current
      input.map do |stock_row|
        {
          symbol: stock_row.display_symbol,
          exchange_id: exchange_id,
          name_en: stock_row.description,
          last_source: "PopulateMoexSymbols #{time_now}",
          last_source_initial_attributes: stock_row,
          created_at: time_now,
          updated_at: time_now
        }
      end
    end

    def create_or_update_moex_assets_symbols(input)
      Success(symbols: AssetSymbol.upsert_all(input))
    rescue => e
      Failure(e)
    end

    def data_from_made_request
      @data_from_made_request ||= FinnhubConfig.api.stock_symbols(MOEX_FINNHUB_EXCHANGE_SYMBOL)
    end
  end
end
