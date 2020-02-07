require 'csv' # frozen_string_literal: true
FILE = 'btc.csv'

bitcoin_data = CSV.parse(File.read(FILE), headers: true, col_sep: ',')
total_issuance = 0
bitcoin_data = bitcoin_data[bitcoin_data.length - 365..bitcoin_data.length]
bitcoin_data.each { |data| total_issuance += data['IssTotUSD'].to_f }

todays_issuance = bitcoin_data[-1]['IssTotUSD'].to_i
ma365 = total_issuance / 365.0
puell_multiple = todays_issuance / ma365.to_f
puts "Puell Multiple for #{Date.today - 1}: #{puell_multiple.round(3)}"
