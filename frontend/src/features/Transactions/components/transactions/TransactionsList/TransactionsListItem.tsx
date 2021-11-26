import React from "react";
import { GetTransactions_transactions as Transaction } from "../../../hooks/__generated__/GetTransactions";

const TransactionsListItem: React.FC<{ transaction: Transaction }> = ({
  transaction,
}: {
  transaction: Transaction;
}) => {
  return (
    <div id={transaction.id}>
      <p>{transaction.action}</p>
      <p>
        {transaction.asset.assetSymbol.nameEn}
        {" / "}
        {transaction.asset.assetSymbol.symbol}
      </p>
      <p>{transaction.date}</p>
      <p>{transaction.quantity}</p>
      <p>{transaction.priceForOneAssetPresented}</p>
      <p>{transaction.totalPriceCommissionPresented}</p>
      <p>{transaction.accuredInterestPresented}</p>
      <p>{transaction.totalPricePresented}</p>
    </div>
  );
};

export default TransactionsListItem;
