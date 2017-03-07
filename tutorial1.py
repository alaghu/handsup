'''
(c) 2011, 2012 Georgia Tech Research Corporation
This source code is released under the New BSD license.  Please see
http://wiki.quantsoftware.org/index.php?title=QSTK_License
for license details.

Created on January, 24, 2013

@author: Sourabh Bajaj
@contact: sourabhbajaj@gatech.edu
@summary: Example tutorial code.
'''

# QSTK Imports
import QSTK.qstkutil.qsdateutil as du
import QSTK.qstkutil.tsutil as tsu
import QSTK.qstkutil.DataAccess as da

# Third Party Imports
import datetime as dt
import matplotlib.pyplot as plt
import pandas as pd

print "Pandas Version as Anand", pd.__version__


def main():
    ''' Main Function'''

    # List of symbols
    # An array
    ls_symbols = ["AAPL", "GLD", "GOOG", "$SPX", "XOM"]

    # Anand trying out array
    anand_symbols = ["ORCL", "AMD", "CRM"]
    print anand_symbols

    # Start and End date of the charts
    dt_start = dt.datetime(2006, 1, 1)
    dt_end = dt.datetime(2010, 12, 31)

    # Anand trying out a variable with datatime method from dt
    anand_start = dt.datetime(2012, 2, 28)
    anand_end = dt.datetime(2013, 12, 31)
    print anand_start

    # We need closing prices so the timestamp should be hours=16.
    dt_timeofday = dt.timedelta(hours=16)

    # Anand trying out time delta. Not sure what this yields yet. It returns 13:00:00 for 13
    anand_timeofday = dt.timedelta(hours=16)
    print anand_timeofday

    # Get a list of trading days between the start and the end.
    ldt_timestamps = du.getNYSEdays(dt_start, dt_end, dt_timeofday)

    # Anand trying out getNYSEdays - returns "Timestamp('working date of NYSE and time')
    anand_timestamps = du.getNYSEdays(anand_start, anand_end, anand_timeofday)
    print anand_timestamps

    # Creating an object of the dataaccess class with Yahoo as the source.
    c_dataobj = da.DataAccess('Yahoo')

    # Anand trying out DataAccess - This is the directory that contains csv files
    # / usr / local / lib / python2.7 / dist - packages / QSTK - 0.2.8 - py2.7.egg / QSTK / QSData / Yahoo
    # http: // wiki.quantsoftware.org / index.php?title = Qstkutil.DataAccess
    anand_dataobj = da.DataAccess('Yahoo')
    print anand_dataobj

    # Keys to be read from the data, it is good to read everything in one go.
    ls_keys = ['open', 'high', 'low', 'close', 'volume', 'actual_close']

    # Anand Trying out ls_keys (another array) - These should be cole column headers in csv files?
    anand_keys = ['open', 'high', 'low', 'close', 'volume', 'actual_close']

    # Reading the data, now d_data is a dictionary with the keys above.
    # Timestamps and symbols are the ones that were specified before.
    ldf_data = c_dataobj.get_data(ldt_timestamps, ls_symbols, ls_keys)
    d_data = dict(zip(ls_keys, ldf_data))

    # Anand Trying to read  the data
    anand_ldf_data = anand_dataobj.get_data(anand_timestamps, anand_symbols, anand_keys)

    anand_d_data = dict(zip(anand_keys, anand_ldf_data))

    # Filling the data for NAN
    for s_key in ls_keys:
        d_data[s_key] = d_data[s_key].fillna(method='ffill')
        d_data[s_key] = d_data[s_key].fillna(method='bfill')
        d_data[s_key] = d_data[s_key].fillna(1.0)

    # Anand Trying filling the data for NAN
    # TODO: No idea how his code works
    for anand_s_key in anand_keys:
        anand_d_data[anand_s_key] = anand_d_data[anand_s_key].fillna(method='ffill')
        anand_d_data[anand_s_key] = anand_d_data[anand_s_key].fillna(method='bfill')
        anand_d_data[anand_s_key] = anand_d_data[s_key].fillna(1.0)

    # Getting the numpy ndarray of close prices.
    na_price = d_data['close'].values

    # Anand trying numpy ndarray of close price
    anand_na_price = anand_d_data['close'].values


    # Plotting the prices with x-axis=timestamps
    plt.clf()
    plt.plot(ldt_timestamps, na_price)
    plt.legend(ls_symbols)
    plt.ylabel('Adjusted Close')
    plt.xlabel('Date')
    plt.savefig('adjustedclose.pdf', format='pdf')

    # Anand Trying the Plotting the prices with x-axis= time stamps
    plt.clf()
    plt.plot(anand_timestamps, anand_na_price)
    plt.legend(anand_symbols)
    plt.ylabel('Adjusted Close')
    plt.xlabel('Date')
    plt.savefig('Anandadjustedclose.pdf', format='pdf')

    # Normalizing the prices to start at 1 and see relative returns
    na_normalized_price = na_price / na_price[0, :]

    # Plotting the prices with x-axis=timestamps
    plt.clf()
    plt.plot(ldt_timestamps, na_normalized_price)
    plt.legend(ls_symbols)
    plt.ylabel('Normalized Close')
    plt.xlabel('Date')
    plt.savefig('normalized.pdf', format='pdf')

    # Copy the normalized prices to a new ndarry to find returns.
    na_rets = na_normalized_price.copy()

    # Calculate the daily returns of the prices. (Inplace calculation)
    # returnize0 works on ndarray and not dataframes.
    tsu.returnize0(na_rets)

    # Plotting the plot of daily returns
    plt.clf()
    plt.plot(ldt_timestamps[0:50], na_rets[0:50, 3])  # $SPX 50 days
    plt.plot(ldt_timestamps[0:50], na_rets[0:50, 4])  # XOM 50 days
    plt.axhline(y=0, color='r')
    plt.legend(['$SPX', 'XOM'])
    plt.ylabel('Daily Returns')
    plt.xlabel('Date')
    plt.savefig('rets.pdf', format='pdf')

    # Plotting the scatter plot of daily returns between XOM VS $SPX
    plt.clf()
    plt.scatter(na_rets[:, 3], na_rets[:, 4], c='blue')
    plt.ylabel('XOM')
    plt.xlabel('$SPX')
    plt.savefig('scatterSPXvXOM.pdf', format='pdf')

    # Plotting the scatter plot of daily returns between $SPX VS GLD
    plt.clf()
    plt.scatter(na_rets[:, 3], na_rets[:, 1], c='blue')  # $SPX v GLD
    plt.ylabel('GLD')
    plt.xlabel('$SPX')
    plt.savefig('scatterSPXvGLD.pdf', format='pdf')


if __name__ == '__main__':
    main()
