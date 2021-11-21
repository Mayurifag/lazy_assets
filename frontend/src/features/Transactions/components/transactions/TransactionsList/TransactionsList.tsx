import React from "react";
import { GetTransactions_transactions as Transaction } from "../../../hooks/__generated__/GetTransactions";
import TransactionsListItem from "./TransactionsListItem";
import { Text } from "react-native";

interface TransactionsProps {
  transactions: Transaction[];
}

const TransactionsList: React.FC<TransactionsProps> = ({
  transactions,
}: TransactionsProps) => {
  console.log(transactions);
  return (
    <>
      <div className="transactions-list">
        {transactions.map((transaction) => (
          <div key={transaction.id}>
            <TransactionsListItem transaction={transaction} />
          </div>
        ))}
      </div>
    </>
  );
};
export default TransactionsList;
