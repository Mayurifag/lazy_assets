import { ApolloClient, InMemoryCache } from "@apollo/client";
import { API_GRAPHQL_URL } from "@env";

const apolloClient = new ApolloClient({
  uri: API_GRAPHQL_URL,
  cache: new InMemoryCache(),
});

export default apolloClient;
