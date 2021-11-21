/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: GetTransactions
// ====================================================

export interface GetTransactions_getTransactions_asset {
  __typename: "Asset";
  id: string;
  assetSymbolId: number;
  quantity: number;
}

export interface GetTransactions_getTransactions {
  __typename: "Transaction";
  id: string;
  asset: GetTransactions_getTransactions_asset;
}

export interface GetTransactions {
  /**
   * Returns a list of transactions
   */
  getTransactions: GetTransactions_getTransactions[];
}
