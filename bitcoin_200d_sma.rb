require './bitcoin_analyser'

analyser = BitcoinAnalyser.new
puts "SMA 200 days = $#{analyser.calculate_moving_average(200)}"
puts "Mayer Multiple = #{analyser.mayer_multiple}"
