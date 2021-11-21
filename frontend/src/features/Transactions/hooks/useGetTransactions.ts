import { gql, useQuery } from "@apollo/client";
import { GetTransactions_transactions as Transaction } from "./__generated__/GetTransactions";

export const GET_TRANSACTIONS = gql`
  query GetTransactions {
    transactions {
      id
      asset {
        id
        assetSymbolId
        quantity
      }
    }
  }
`;

export const useGetTransactions = (): Transaction[] | undefined => {
  const { data } = useQuery(GET_TRANSACTIONS);
  return data?.transactions;
};
