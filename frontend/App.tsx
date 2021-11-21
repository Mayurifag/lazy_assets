import { ApolloProvider } from "@apollo/client";
import React from "react";
// import { Text, View } from "react-native";
// import { StatusBar } from "expo-status-bar";
import TransactionsPage from "./src/features/Transactions/pages/TransactionsPage";
import apolloClient from "./src/apollo-client";

export default function App() {
  return (
    // <View>
    //   <Text>Open up App.tsx to start working on your app!</Text>
    //   <StatusBar style="auto" />
    // </View>
    <ApolloProvider client={apolloClient}>
      <TransactionsPage />
    </ApolloProvider>
  );
}
