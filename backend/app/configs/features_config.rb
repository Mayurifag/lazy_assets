# Not sure about naming here. Maybe move to application config / name like
# rails_config or idk
class FeaturesConfig < ApplicationConfig
  def enable_graphiql?
    not_production?
  end

  def enable_sidekiq_dashboard?
    not_production?
  end

  private

  def production?
    Rails.env.production?
  end

  def not_production?
    !production?
  end
end
