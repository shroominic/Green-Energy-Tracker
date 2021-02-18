import requests, json, time
import pandas as pd
from io import StringIO

# get unix timestamp in milliseconds    
timestamp = int(time.time()) * 1000

# request smard data with default values
def requestSmardData(
    modulIDs = [8004169], 
    timestamp_from_in_milliseconds = (int(time.time()) * 1000) - (4*3600)*1000, 
    timestamp_to_in_milliseconds   = (int(time.time()) * 1000),
    region   = "DE",
    language = "de",
    type     = "discrete"
    ):
    
    # http request content
    url  = "https://www.smard.de/nip-download-manager/nip/download/market-data"
    body = json.dumps({
        "request_form": [
            {
                "format": "CSV",
                "moduleIds": modulIDs,
                "region": region,
                "timestamp_from": timestamp_from_in_milliseconds,
                "timestamp_to": timestamp_to_in_milliseconds,
                "type": type,
                "language": language
            }]})
    
    # http response
    data = requests.post(url, body)

    # create pandas dataframe out of response string (csv)
    df = pd.read_csv(StringIO(data.text), sep=';')
    
    return df


### ModulIDs ###  (TODO: Only Germany?)

# power generation 
REALIZED_POWER_GENERATION    = [1001224,1004066,1004067,1004068,1001223,1004069,1004071,1004070,1001226,1001228,1001227,1001225]
INSTALLED_POWER_GENERATION   = [3004072,3004073,3004074,3004075,3004076,3000186,3000188,3000189,3000194,3000198,3000207,3003792]
FORECASTED_POWER_GENERATION  = [2000122, 2000715, 2000125, 2003791, 2000123]

# power consumption
FORECASTED_POWER_CONSUMPTION = [6000411, 6004362]
REALIZED_POWER_CONSUMPTION   = [5000410, 5004359]

# market
WHOLESALE_PRICES             = [8004169,8004170,8000252,8000253,8000251,8000254,8000255,8000256,8000257,8000258,8000259,8000260,8000261,8000262]
COMMERCIAL_FOREIGN_TRADE     = [8004169,8004170,8000252,8000253,8000251,8000254,8000255,8000256,8000257,8000258,8000259,8000260,8000261,8000262]
PHYSICAL_POWER_FLOW          = [31000714,31000140,31000569,31000145,31000574,31000570,31000139,31000568,31000138,31000567,31000146,31000575,31000144,31000573,31000142,31000571,31000143,31000572,31000141]

df = requestSmardData(modulIDs=REALIZED_POWER_CONSUMPTION)
print(df)