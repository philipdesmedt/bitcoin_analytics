# WIP: Below data is wrong.

require 'csv' # frozen_string_literal: true
FILE = 'btc.csv'

days = 365 if ARGV.empty? || !ARGV[0].to_i.is_a?(Numeric)
bitcoin_data = CSV.parse(File.read(FILE), headers: true, col_sep: ',')
days ||= ARGV[0].to_i
bitcoin_data = bitcoin_data[bitcoin_data.length - days..bitcoin_data.length]
daily_growth_rate = 0

bitcoin_data.each_with_index do |data, index|
  next unless index.positive?

  adr_count = data['AdrActCnt'].to_i
  prev_adr_count = bitcoin_data[index - 1]['AdrActCnt'].to_i
  daily_growth_rate += (adr_count / prev_adr_count.to_f) - 1
end

puts "Average daily growth rate of addresses over the last #{days} days: #{(daily_growth_rate / days * 100).round(2)}%"
