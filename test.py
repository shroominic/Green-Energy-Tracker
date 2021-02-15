import requests, json, time
import pandas as pd

url = "https://www.smard.de/nip-download-manager/nip/download/market-data"

timestamp = int(time.time()) * 1000

data = json.dumps(
    {
    "request_form": [
        {
            "format": "CSV",
            "moduleIds": [8004169],
            "region": "DE",
            "timestamp_from": timestamp - 6*3600000,
            "timestamp_to": timestamp,
            "type": "discrete",
            "language": "de"
        }
    ]})

r = requests.post(url, data)

print(timestamp)

with open("output.csv", "w") as file:
    text = r.text.replace(',', '&').replace(';', ',').replace('&', ';')
    file.write(text)
    

