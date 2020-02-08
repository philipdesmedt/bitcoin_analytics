require './bitcoin_analyser'

puts 'Calculating 200 week moving averages since 2012:'

end_date = Date.parse('2012-01-01')
all_wma = []
index = 0
analyser = BitcoinAnalyser.new

while end_date <= Date.today
  wma = analyser.calculate_moving_average(1400, use_maximum_number_of_points: true, end_date: end_date)
  growth_rate = 0
  all_wma << wma
  if all_wma.length > 1
    growth_rate = ((wma / all_wma[index].to_f) * 100) - 100
    index += 1
  end
  puts "200 WMA on #{end_date}: $#{wma} with growth rate #{growth_rate.round(2)}%"
  end_date += 31
end
