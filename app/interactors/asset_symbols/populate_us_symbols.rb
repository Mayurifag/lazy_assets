module AssetSymbols
  # Идемпотентно пополняет AssetSymbols тикерами с американских бирж
  class PopulateUsSymbols < BaseInteractor
    include Dry::Transaction

    US_FINNHUB_EXCHANGE_SYMBOL = "US"
    US_EXCHANGES_FOR_ASSETS = %w[OOTC XNAS ARCX XNYS BATS XASE]
    private_constant :US_FINNHUB_EXCHANGE_SYMBOL, :US_EXCHANGES_FOR_ASSETS

    step :request_us_stocks
    map :filter_not_used_exchanges
    map :make_attributes_for_upsert_all
    step :create_or_update_us_assets_symbols

    private

    def request_us_stocks
      if data_from_made_request.present?
        Success(data_from_made_request)
      else
        # TODO: logging, retry, etc.
        Failure(:api_error)
      end
    end

    # input.uniq { |h| h.mic }:
    # 1) OOTC - Other OTC - 16572 // thinking if I really need it
    # 2) XNAS - NASDAQ - 5088
    # 3) ARCX - NYSE Arca - 1774
    # 4) XNYS - NYSE - 3621
    # 5) BATS - CBOE BZX U.S. Equities Exchange - 520
    # 6) IEXG - testing // not needed
    # 7) XASE - NYSE Market LLC
    # Im not deleting (6), but see if only (1,2,3,4,5) were in scope just
    # because I want to be sure everything gonna be ok when they will add
    # another exchange there
    def filter_not_used_exchanges(input)
      input.find_all { |stock_row| stock_row.mic.in? US_EXCHANGES_FOR_ASSETS }
    end

    def make_attributes_for_upsert_all(input)
      time_now = Time.current
      input.map do |stock_row|
        {
          symbol: stock_row.display_symbol,
          exchange_id: exchange_id_by_mic(stock_row.mic),
          name_en: stock_row.description,
          last_source: "PopulateUsSymbols #{time_now}",
          last_source_initial_attributes: stock_row,
          created_at: time_now,
          updated_at: time_now
        }
      end
    end

    def exchange_id_by_mic(mic)
      @exchange_id_by_mic ||= Hash.new do |h, key|
        h[key] = Exchange.find_by(mic: key).id
      end
      @exchange_id_by_mic[mic]
    end

    def create_or_update_us_assets_symbols(input)
      Success(symbols: AssetSymbol.upsert_all(input))
    rescue => e
      Failure(e)
    end

    def data_from_made_request
      @data_from_made_request ||= FinnhubRuby::DefaultApi.new.stock_symbols(US_FINNHUB_EXCHANGE_SYMBOL)
    end
  end
end
