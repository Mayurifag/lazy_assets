import React from "react";
import { useGetTransactions } from "../hooks/useGetTransactions";
import TransactionsList from "../components/transactions/TransactionsList/TransactionsList";
import TransactionsListDataGrid from "../components/transactions/TransactionsList/TransactionsListDataGrid";

const TransactionsPage: React.FC = () => {
  const transactions = useGetTransactions();

  return (
    <>
      <TransactionsList transactions={transactions || []} />
      <TransactionsListDataGrid transactions={transactions || []} />
    </>
  );
};

export default TransactionsPage;
