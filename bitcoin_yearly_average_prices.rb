require './bitcoin_analyser'

puts 'Calculating 365 daily moving averages per year since conception:'

analyser = BitcoinAnalyser.new

puts "Average price in 2010: $#{analyser.calculate_moving_average(365, start_date: '2010-01-01', end_date: '2011-01-01')}"
puts "Average price in 2011: $#{analyser.calculate_moving_average(365, start_date: '2011-01-01', end_date: '2012-01-01')}"
puts "Average price in 2012: $#{analyser.calculate_moving_average(365, start_date: '2012-01-01', end_date: '2013-01-01')}"
puts "Average price in 2013: $#{analyser.calculate_moving_average(365, start_date: '2013-01-01', end_date: '2014-01-01')}"
puts "Average price in 2014: $#{analyser.calculate_moving_average(365, start_date: '2014-01-01', end_date: '2015-01-01')}"
puts "Average price in 2015: $#{analyser.calculate_moving_average(365, start_date: '2015-01-01', end_date: '2016-01-01')}"
puts "Average price in 2016: $#{analyser.calculate_moving_average(365, start_date: '2016-01-01', end_date: '2017-01-01')}"
puts "Average price in 2017: $#{analyser.calculate_moving_average(365, start_date: '2017-01-01', end_date: '2018-01-01')}"
puts "Average price in 2018: $#{analyser.calculate_moving_average(365, start_date: '2018-01-01', end_date: '2019-01-01')}"
puts "Average price in 2019: $#{analyser.calculate_moving_average(365, start_date: '2019-01-01', end_date: '2020-01-01')}"
