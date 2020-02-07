require 'csv' # frozen_string_literal: true
FILE = 'btc.csv'
return if ARGV.empty?
return unless ARGV[0].to_i.is_a?(Numeric)

bitcoin_data = CSV.parse(File.read(FILE), headers: true, col_sep: ',')
sma_days = ARGV[0].to_i
bitcoin_data = bitcoin_data[bitcoin_data.length - sma_days..bitcoin_data.length]
total_price = 0

bitcoin_data.each { |data| total_price += data['PriceUSD'].to_f }
sma = (total_price / bitcoin_data.length).round(2)
puts "SMA #{bitcoin_data.length} days = $#{sma}"
