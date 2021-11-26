import React from "react";
import { GetTransactions_transactions as Transaction } from "../../../hooks/__generated__/GetTransactions";
import TransactionsListItem from "./TransactionsListItem";
import { StyleSheet, View } from "react-native";

interface TransactionsProps {
  transactions: Transaction[];
}

const styles = StyleSheet.create({
  list: {
    flexDirection: "row",
  },
  element: {
    margin: 10,
  },
});

const TransactionsList: React.FC<TransactionsProps> = ({
  transactions,
}: TransactionsProps) => {
  return (
    <View style={styles.list}>
      {transactions.map((transaction) => (
        <View style={styles.element} key={transaction.id}>
          <TransactionsListItem transaction={transaction} />
        </View>
      ))}
    </View>
  );
};
export default TransactionsList;
