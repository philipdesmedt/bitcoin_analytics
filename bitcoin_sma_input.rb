require 'csv' # frozen_string_literal: true
FILE = 'btc.csv'
if ARGV.empty? || !ARGV[0].to_i.is_a?(Numeric)
  puts 'Please specify the number of days for which you want to calculate the SMA'
  return
end

bitcoin_data = CSV.parse(File.read(FILE), headers: true, col_sep: ',')
if ARGV[1] && ARGV[2]
  start_date = ARGV[1].split('=')
  end_date = ARGV[2].split('=')
  if start_date.length > 1
    parsed_start_date = Date.parse(start_date[1])
    bitcoin_data.delete_if { |row| Date.parse(row['date']) < parsed_start_date }
  end
  if end_date.length > 1
    parsed_end_date = Date.parse(end_date[1])
    bitcoin_data.delete_if { |row| Date.parse(row['date']) > parsed_end_date }
  end
end

puts "Number of datapoints: #{bitcoin_data.length}"
puts "Start date to consider is #{bitcoin_data[0]['date']}"
puts "End date to consider is #{bitcoin_data[-1]['date']}"
sma_days = ARGV[0].to_i
if sma_days > bitcoin_data.length
  puts 'ERROR: Moving Average Days is greater than # of data points'
  return
end

bitcoin_data = bitcoin_data[bitcoin_data.length - sma_days..bitcoin_data.length]
total_price = 0

bitcoin_data.each { |data| total_price += data['PriceUSD'].to_f }
sma = (total_price / bitcoin_data.length).round(2)
puts "SMA #{bitcoin_data.length} days = $#{sma}"
