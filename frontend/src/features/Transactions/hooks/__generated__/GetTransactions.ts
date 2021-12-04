/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: GetTransactions
// ====================================================

export interface GetTransactions_transactions_assetSymbol_exchange {
  __typename: "Exchange";
  name: string;
}

export interface GetTransactions_transactions_assetSymbol {
  __typename: "AssetSymbol";
  nameEn: string | null;
  symbol: string | null;
  exchange: GetTransactions_transactions_assetSymbol_exchange;
}

export interface GetTransactions_transactions_broker {
  __typename: "Broker";
  name: string;
}

export interface GetTransactions_transactions {
  __typename: "Transaction";
  action: string | null;
  id: string;
  assetSymbol: GetTransactions_transactions_assetSymbol;
  broker: GetTransactions_transactions_broker;
  quantity: number;
  priceForOneAssetInCents: number;
  accuredInterestInCents: number | null;
  currency: string;
  date: any | null;
  totalPricePresented: string;
  totalPriceCommissionPresented: string;
  priceForOneAssetPresented: string;
  accuredInterestPresented: string;
}

export interface GetTransactions {
  /**
   * Returns a list of transactions
   */
  transactions: GetTransactions_transactions[];
}
