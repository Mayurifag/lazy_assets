module AssetSymbols
  class UpdateAssetSymbolCompanyProfileInfo < BaseInteractor
    class Contract < BaseContract
      params do
        required(:asset_symbol).filled(type?: AssetSymbol)
      end
    end

    include Dry::Transaction

    validate_input contract: Contract
    step :request_company_profile
    map :set_attributes_for_asset
    step :save_asset_symbol
    # TODO: async step download image

    private

    def request_company_profile(input)
      company_profile = company_profile_from_api(input[:asset_symbol])
      if company_profile.present?
        input[:company_profile] = company_profile
        Success(input)
      else
        # TODO: logging, retry, etc.
        Failure(:api_error)
      end
    end

    def set_attributes_for_asset(input)
      asset_symbol = input[:asset_symbol]
      asset_symbol.country = input[:company_profile].country
      asset_symbol.original_logo_url = input[:company_profile].logo
      asset_symbol.sector = Sector.find_or_initialize_by(name_en: input[:company_profile].finnhub_industry)
      input.merge(asset_symbol: asset_symbol)
    end

    def save_asset_symbol(input)
      input[:asset_symbol].save!
      Success(input[:asset_symbol])
    rescue => e
      Failure(e)
    end

    def company_profile_from_api(asset_symbol)
      @quote ||= FinnhubConfig.api.company_profile2(symbol: asset_symbol.symbol)
    end
  end
end
