module AssetsSymbols
  # Идемпотентно пополняет AssetsSymbols акциями с Московской Биржи, исключая
  # иностранные тикеры, которые берутся с US бирж
  class PopulateMoexStocks < BaseInteractor
    include Dry::Transaction

    step :request_me_stocks
    step :save_transaction
    tee :publish_event

    private

    def request_me_stocks
      
    end
  end
end
