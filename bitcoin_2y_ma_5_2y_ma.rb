require 'csv' # frozen_string_literal: true
FILE = 'btc.csv'

bitcoin_data = CSV.parse(File.read(FILE), headers: true, col_sep: ',')
total_price = 0
bitcoin_data = bitcoin_data[bitcoin_data.length - 730..bitcoin_data.length]
bitcoin_data.each { |data| total_price += data['PriceUSD'].to_f }

sma = (total_price / bitcoin_data.length).round(2)
puts 'Ideal time to sell BTC into fiat based on historical data is above 5*SMA(730)'
puts "SMA #{bitcoin_data.length} days = $#{sma}"
puts "5 * SMA #{bitcoin_data.length} days = $#{5 * sma}"
