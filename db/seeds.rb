# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

BROKERS = [
  {id: 1, name: "Other"},
  {id: 2, name: "Binance"},
  {id: 3, name: "KuCoin"},
  {id: 4, name: "Interactive Brokers"},
  {id: 5, name: "Открытие"},
  {id: 6, name: "Тинькофф"},
  {id: 7, name: "ВТБ"}
]

Broker.insert_all!(BROKERS)
