# Not sure about naming here. Maybe move to application config / name like
# rails_config or idk
class FeaturesConfig < ApplicationConfig
  def enable_graphiql?
    !Rails.env.production?
  end

  def use_rails_api_only?
    !enable_graphiql?
  end
end
