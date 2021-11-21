import React from "react";
import { Text } from "react-native";
import { useGetTransactions } from "../hooks/useGetTransactions";
import TransactionsList from "../components/transactions/TransactionsList/TransactionsList";

const TransactionsPage: React.FC = () => {
  const transactions = useGetTransactions();

  return (
    <div className="transactions">
      <TransactionsList transactions={transactions || []} />
    </div>
  );
};

export default TransactionsPage;
