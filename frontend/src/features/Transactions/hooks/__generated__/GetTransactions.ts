/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: GetTransactions
// ====================================================

export interface GetTransactions_transactions_asset {
  __typename: "Asset";
  id: string;
  assetSymbolId: number;
  quantity: number;
}

export interface GetTransactions_transactions {
  __typename: "Transaction";
  id: string;
  asset: GetTransactions_transactions_asset;
}

export interface GetTransactions {
  /**
   * Returns a list of transactions
   */
  transactions: GetTransactions_transactions[];
}
