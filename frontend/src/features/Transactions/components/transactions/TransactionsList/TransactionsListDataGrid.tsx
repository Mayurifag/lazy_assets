import React from "react";
import { GetTransactions_transactions as Transaction } from "../../../hooks/__generated__/GetTransactions";
import { StyleSheet } from "react-native";
import DataGrid, { SelectColumn, FormatterProps } from "react-data-grid";
import type { Column } from "react-data-grid";

interface TransactionsProps {
  transactions: Transaction[];
}

// https://github.com/adazzle/react-data-grid/blob/main/website/demos/AllFeatures.tsx

const columns: readonly Column<Transaction>[] = [
  // SelectColumn,
  {
    key: "action",
    name: "Action",
    width: 50,
    resizable: true,
  },
  {
    key: "asset",
    name: "Asset",
    // width: 200,
    resizable: true,
    formatter: ({ row }: FormatterProps<Transaction, unknown>) => {
      return (
        <>
          {row.assetSymbol.nameEn}
          {" / "}
          {row.assetSymbol.symbol}
        </>
      );
    },
  },
  {
    key: "date",
    name: "Date",
    width: 100,
    resizable: true,
  },
  {
    key: "quantity",
    name: "Quantity",
    width: 100,
    resizable: true,
  },
  {
    key: "priceForOneAssetPresented",
    name: "Price for 1 asset",
    width: 120,
  },
  {
    key: "totalPriceCommissionPresented",
    name: "Commission",
    width: 100,
  },
  {
    key: "accuredInterestPresented",
    name: "NKD",
    width: 40,
  },
  {
    key: "totalPricePresented",
    name: "Total Assets Price",
    width: 150,
  },
];

const styles = StyleSheet.create({
  // list: {
  //   flexDirection: "row",
  // },
  // element: {
  //   margin: 10,
  // },
});

const TransactionsListDataGrid: React.FC<TransactionsProps> = ({
  transactions,
}: TransactionsProps) => {
  return (
    <>
      <DataGrid
        columns={columns}
        rows={transactions}
        rowClass={(row: Transaction) => row.id}
      />
    </>
  );
};
export default TransactionsListDataGrid;
