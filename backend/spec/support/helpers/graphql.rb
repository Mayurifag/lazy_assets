def graphql_raw_post(raw:, variables: {})
  data = {
    query: raw,
    variables: variables
  }
  post :execute, body: data.to_json, as: :json, xhr: true
end

# def graphql_error?
#   data = graphql_data
#   data[data.keys.first].key?("errors")
# end

# def graphql_response
#   JSON.parse(response.body, object_class: OpenStruct)
# end

def graphql_data
  JSON.parse(response.body)["data"]
end

# def graphql_errors
#   JSON.parse(response.body)["errors"].first
# rescue
#   nil
# end

# module GraphqlMatchers
#   extend RSpec::Matchers::DSL

#   matcher :has_graphql_errors do
#     data = JSON.parse(response.body)["data"]
#     data[data.keys.first]["errors"]
#   end
# end
