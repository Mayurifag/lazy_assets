# Config for https://github.com/Finnhub-Stock-API/finnhub-ruby
class FinnhubConfig < ApplicationConfig
  config_name :finnhub
  attr_config :api_key

  def api
    @api ||= FinnhubRuby::DefaultApi.new
  end
end
