require 'csv' # frozen_string_literal: true
FILE = 'btc.csv'

bitcoin_data = CSV.parse(File.read(FILE), headers: true, col_sep: ',')
total_price = 0
bitcoin_data = bitcoin_data[bitcoin_data.length - 200..bitcoin_data.length]
bitcoin_data.each { |data| total_price += data['PriceUSD'].to_f }

sma = (total_price / bitcoin_data.length).round(2)
puts "SMA #{bitcoin_data.length} days = $#{sma}"
mm = (bitcoin_data[-1]['PriceUSD'].to_f / sma).round(2)
puts "Mayer Multiple = #{mm}"
