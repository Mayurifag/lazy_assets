Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if FeaturesConfig.enable_graphiql?
  if FeaturesConfig.enable_sidekiq_dashboard?
    require "sidekiq/web"
    mount Sidekiq::Web, at: "/sidekiq"
  end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"
end
