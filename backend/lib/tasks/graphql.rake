# https://github.com/rmosolgo/graphql-ruby/issues/2501
# rails graphql:schema:dump dumps both a schema.graphql and a schema.json
# rails graphql:schema:json dumps only a schema.json
# rails graphql:schema:idl dumps only a schema.graphql
namespace :graphql do
  task dump_schema: :environment do
    require "graphql/rake_task"

    GraphQL::RakeTask.new(
      load_schema: ->(_task) {
        require File.expand_path("../../app/graphql/api_schema", __dir__)
        ApiSchema
      },
      directory: "./config/"
    )
    Rake::Task["graphql:schema:json"].invoke
  end
end
