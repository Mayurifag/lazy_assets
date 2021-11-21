import React from "react";
import { GetTransactions_transactions as Transaction } from "../../../hooks/__generated__/GetTransactions";

const TransactionsListItem: React.FC<{ transaction: Transaction }> = ({
  transaction,
}: {
  transaction: Transaction;
}) => {
  return (
    <div>
      <p>{transaction.id}</p>
      <p>{transaction.asset.quantity}</p>
    </div>
  );
};

export default TransactionsListItem;
