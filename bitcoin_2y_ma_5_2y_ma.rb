require './bitcoin_analyser'

analyser = BitcoinAnalyser.new

puts 'Ideal time to sell BTC into fiat based on historical data is above 5*SMA(730)'
sma = analyser.calculate_moving_average(730)
puts "SMA 730 days = $#{sma}"
puts "5 * SMA 730 days = $#{5 * sma}"
