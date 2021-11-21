import { ApolloClient, InMemoryCache } from "@apollo/client";

// TODO: change uri for ENV
const apolloClient = new ApolloClient({
  uri: "localhost:3000/graphql",
  cache: new InMemoryCache(),
});

export default apolloClient;
