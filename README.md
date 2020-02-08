# Bitcoin Analysis in Ruby

## How to Use

Download the last Bitcoin data file from coinmetrics.io (https://coinmetrics.io/newdata/btc.csv). Then run the Ruby scripts.

You can find out what the columns mean on https://coinmetrics.io/community-data-dictionary/

## Scripts

1. bitcoin_1458d_sma.rb

Calculates the 1458 daily simple moving average (SMA) price for Bitcoin. 1458 days equals 4 years. This price has historically been a long term support for bitcoin. The price rarely goes under this number and when it hovers around it, it has historically been a great time to buy.

2. bitcoin_200d_sma.rb

Calculates the 200 daily SMA. Used to calculate the Mayer Multiple, which is a number that indicates whether Bitcoin is going into oversold, bearish, bullish or overbought territory.

3. bitcoin_2y_ma_5_2y_ma.rb

Calculates the 730 daily SMA and the 5 * 730 daily SMA (in price, not in # of days). Historically, a good time to sell BTC into fiat is above 5 * SMA(730).

4. bitcoin_sma_input.rb

Calculates a daily SMA based on your number input. Optional start_date and end_date. Examples:
```
	ruby bitcoin_sma_input.rb 1400
	ruby bitcoin_sma_input.rb 1400 start_date= end_date=2020-01-03
	ruby bitcoin_sma_input.rb 31 start_date=2020-01-01 end_date=2020-01-31
```

Or use the `BitcoinAnalysis` class:

```
  require './bitcoin_analysis'
  analyser = BitcoinAnalyser.new
```

The other scripts are experimental and don't have anything proven (yet).

**Note: none of these scripts are financial advice. Use at your own risk. Never invest what you cannot afford to lose. I did not invent these metrics, I'm only playing around with publicly available data.**
