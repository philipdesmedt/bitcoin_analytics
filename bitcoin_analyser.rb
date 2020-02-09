require 'csv' # frozen_string_literal: true

class BitcoinAnalyser
  attr_reader :file

  def initialize(file = 'btc.csv')
    @file = file
  end

  def calculate_moving_average(number_of_days, options = {})
    total_price, length = total_by_field('PriceUSD', number_of_days, options)
    (total_price / length).round(2)
  end

  def calculate_average_transactions(number_of_days, options = {})
    total_transactions, length = total_by_field('TxCnt', number_of_days, options)
    (total_transactions / length).round(0)
  end

  def calculate_average_fees_usd(number_of_days, options = {})
    total_transactions, length = total_by_field('FeeTotUSD', number_of_days, options)
    (total_transactions / length).round(2)
  end

  def mayer_multiple
    ma = calculate_moving_average(200)
    (price_today / ma).round(2)
  end

  def sma1458d_multiple
    ma = calculate_moving_average(1458)
    (price_today / ma).round(2)
  end

  def price_today
    load_data[-1]['PriceUSD'].to_f
  end

  def puell_multiple
    todays_issuance = raw_data[-1]['IssTotUSD'].to_i
    total_issuance, length = total_by_field('IssTotUSD', 365)

    ma365 = total_issuance / length.to_f
    (todays_issuance / ma365.to_f).round(3)
  end

  def total_by_field(field_name, number_of_days, options = {})
    bitcoin_data = begin
      if options[:start_date] || options[:end_date]
        select_data_range(options[:start_date], options[:end_date])
      else
        load_data
      end
    end
    start_index = bitcoin_data.length - select_days(bitcoin_data, number_of_days, options)
    bitcoin_data = bitcoin_data[start_index..bitcoin_data.length]
    total = 0

    bitcoin_data.each { |entry| total += entry[field_name].to_f }

    return total, bitcoin_data.length
  end

  def all_time_high_price(options = {})
    bitcoin_data = begin
      if options[:start_date] || options[:end_date]
        select_data_range(options[:start_date], options[:end_date])
      else
        load_data
      end
    end

    current_ath = 0
    bitcoin_data.each do |entry|
      price = entry['PriceUSD'].to_f
      current_ath = price if price > current_ath
    end

    current_ath.round(2)
  end

  def raw_data
    load_data
  end

  private

    def load_data
      CSV.parse(File.read(file), headers: true, col_sep: ',')
    end

    def select_data_range(start_date, end_date)
      bitcoin_data = load_data
      if start_date
        parsed_start_date = Date.parse(start_date.to_s)
        bitcoin_data.delete_if { |row| Date.parse(row['date']) < parsed_start_date }
      end
      if end_date
        parsed_end_date = Date.parse(end_date.to_s)
        bitcoin_data.delete_if { |row| Date.parse(row['date']) > parsed_end_date }
      end

      bitcoin_data
    end

    def select_days(bitcoin_data, number_of_days, options)
      if number_of_days > bitcoin_data.length && options[:use_maximum_number_of_points]
        bitcoin_data.length
      elsif number_of_days < bitcoin_data.length
        number_of_days
      else
        raise 'ERROR: Moving Average Days is greater than # of data points'
      end
    end
end
