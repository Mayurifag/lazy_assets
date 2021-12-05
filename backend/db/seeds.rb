# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "populating brokers and exchanges"

BROKERS = [
  {id: 1, name: "Other"},
  {id: 2, name: "Binance"},
  {id: 3, name: "KuCoin"},
  {id: 4, name: "Interactive Brokers"},
  {id: 5, name: "Открытие"},
  {id: 6, name: "Тинькофф"},
  {id: 7, name: "ВТБ"}
]

Broker.upsert_all(BROKERS)

EXCHANGES = [
  {id: 1, name: "Moscow Stock Exchange", country: "Russia", mic: "MISX"},
  {id: 2, name: "Other OTC", country: "US", mic: "OOTC"},
  {id: 3, name: "Nasdaq", country: "US", mic: "XNAS"},
  {id: 4, name: "NYSE Arca", country: "US", mic: "ARCX"},
  {id: 5, name: "New York Stock Exchange", country: "US", mic: "XNYS"},
  {id: 6, name: "Cboe Bzx U.s. Equities Exchange", country: "US", mic: "BATS"},
  {id: 7, name: "Nyse Mkt LLC", country: "US", mic: "XASE"}
]

Exchange.upsert_all(EXCHANGES)

puts "populating moex"
AssetSymbols::PopulateMoexSymbols.call
# puts "populating us"
# AssetSymbols::PopulateUsSymbols.call

puts "populating transactions"
Transactions::CreateTransaction.call({
  action: "buy",
  date: Date.today,
  currency: "RUB",
  total_price_in_cents: 1000,
  quantity: 10,
  total_price_commission_in_cents: 10,
  asset_symbol: AssetSymbol.find_by(symbol: "SBER.ME"),
  broker: Broker.find_by(name: "Тинькофф")
})

Transactions::CreateTransaction.call({
  action: "buy",
  date: Date.yesterday,
  currency: "RUB",
  total_price_in_cents: 900,
  quantity: 10,
  total_price_commission_in_cents: 50,
  asset_symbol: AssetSymbol.find_by(symbol: "SBER.ME"),
  broker: Broker.find_by(name: "ВТБ")
})

Transactions::CreateTransaction.call({
  action: "buy",
  date: Date.yesterday,
  currency: "RUB",
  total_price_in_cents: 900,
  quantity: 10,
  total_price_commission_in_cents: 50,
  asset_symbol: AssetSymbol.find_by(symbol: "GMKN.ME"),
  broker: Broker.find_by(name: "ВТБ")
})

Transactions::CreateTransaction.call({
  action: "buy",
  date: Date.yesterday,
  currency: "RUB",
  total_price_in_cents: 900,
  quantity: 10,
  total_price_commission_in_cents: 50,
  asset_symbol: AssetSymbol.find_by(symbol: "FXRL.ME"),
  broker: Broker.find_by(name: "ВТБ")
})
