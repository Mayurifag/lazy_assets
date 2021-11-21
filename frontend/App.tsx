import { ApolloProvider } from "@apollo/client";
import React from "react";
import { StatusBar } from "expo-status-bar";
import TransactionsPage from "./src/features/Transactions/pages/TransactionsPage";
import apolloClient from "./src/apollo/apollo-client";

export default function App() {
  return (
    <ApolloProvider client={apolloClient}>
      <TransactionsPage />
      <StatusBar style="auto" />
    </ApolloProvider>
  );
}
