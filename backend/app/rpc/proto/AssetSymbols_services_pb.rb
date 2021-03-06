# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: AssetSymbols.proto for package 'rpc'

require "grpc"
require "AssetSymbols_pb"

module Rpc
  module AssetSymbols
    class Service
      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = "rpc.AssetSymbols"

      rpc :GetAssetSymbolTickerPrice, GetAssetSymbolTickerPriceRequest, GetAssetSymbolTickerPriceResponse
    end

    Stub = Service.rpc_stub_class
  end
end
