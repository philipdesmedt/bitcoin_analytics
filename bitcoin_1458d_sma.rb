require './bitcoin_analyser'

puts "SMA 1458 days = $#{BitcoinAnalyser.new.calculate_moving_average(1458)}"
