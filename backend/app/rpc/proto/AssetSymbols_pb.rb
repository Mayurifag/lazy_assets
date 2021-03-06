# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: AssetSymbols.proto

require "google/protobuf"

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "rpc.Ticker" do
    optional :ticker, :string, 1
    optional :price, :float, 2
    optional :currency, :string, 3
  end
  add_message "rpc.GetAssetSymbolTickerPriceRequest" do
    optional :ticker, :string, 1
  end
  add_message "rpc.GetAssetSymbolTickerPriceResponse" do
    optional :ticker, :message, 1, "rpc.Ticker"
  end
end

module Rpc
  Ticker = Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.Ticker").msgclass
  GetAssetSymbolTickerPriceRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.GetAssetSymbolTickerPriceRequest").msgclass
  GetAssetSymbolTickerPriceResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.GetAssetSymbolTickerPriceResponse").msgclass
end
