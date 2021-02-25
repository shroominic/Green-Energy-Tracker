import 'package:http/http.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

// power generation
List REALIZED_POWER_GENERATION = [
  1001224,
  1004066,
  1004067,
  1004068,
  1001223,
  1004069,
  1004071,
  1004070,
  1001226,
  1001228,
  1001227,
  1001225
];
List INSTALLED_POWER_GENERATION = [
  3004072,
  3004073,
  3004074,
  3004075,
  3004076,
  3000186,
  3000188,
  3000189,
  3000194,
  3000198,
  3000207,
  3003792
];
List FORECASTED_POWER_GENERATION = [
  2000122,
  2000715,
  2000125,
  2003791,
  2000123
];

// power consumption
List FORECASTED_POWER_CONSUMPTION = [6000411, 6004362];
List REALIZED_POWER_CONSUMPTION = [5000410, 5004359];

// market
List WHOLESALE_PRICES = [
  8004169,
  8004170,
  8000252,
  8000253,
  8000251,
  8000254,
  8000255,
  8000256,
  8000257,
  8000258,
  8000259,
  8000260,
  8000261,
  8000262
];
List COMMERCIAL_FOREIGN_TRADE = [
  8004169,
  8004170,
  8000252,
  8000253,
  8000251,
  8000254,
  8000255,
  8000256,
  8000257,
  8000258,
  8000259,
  8000260,
  8000261,
  8000262
];
List PHYSICAL_POWER_FLOW = [
  31000714,
  31000140,
  31000569,
  31000145,
  31000574,
  31000570,
  31000139,
  31000568,
  31000138,
  31000567,
  31000146,
  31000575,
  31000144,
  31000573,
  31000142,
  31000571,
  31000143,
  31000572,
  31000141
];

Map<String, List<dynamic>> csvToMap(String csv) {
  List<List<dynamic>> csvList =
      CsvToListConverter().convert(csv, fieldDelimiter: ';');
  Map<String, List<dynamic>> result = Map();

  for (int i = 0; i < (csvList[0].length); i++) {
    List data = [];
    for (int j = 1; j < (csvList.length); j++) {
      data.add(csvList[j][i]);
    }
    result.putIfAbsent(csvList[0][i], () => data);
  }
  return result;
}

class SmardData {
  SmardData();

  Future<String> requestData(
      {int fromInHoursAgoNow = 24,
      int toInHoursAfterNow = 0,
      Modul modul = Modul.price}) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    var url =
        "https://www.smard.de/nip-download-manager/nip/download/market-data";

    List modules;
    switch (modul) {
      case Modul.consumption:
        modules = FORECASTED_POWER_CONSUMPTION;
        break;
      case Modul.price:
        modules = WHOLESALE_PRICES[0];
        break;
      case Modul.generation:
        modules = REALIZED_POWER_GENERATION;
        break;
      case Modul.forecasted_generation:
        modules = FORECASTED_POWER_GENERATION;
        break;
    }

    var body = json.encode({
      "request_form": [
        {
          "format": "CSV",
          "moduleIds": modules,
          "region": "DE",
          "timestamp_from":
              time - Duration(hours: fromInHoursAgoNow).inMilliseconds,
          "timestamp_to":
              time + Duration(hours: toInHoursAfterNow).inMilliseconds,
          "type": "discrete",
          "language": "de"
        }
      ]
    });

    Response response = await post(url,
        body: body, headers: {"Content-Type": "application/json"});
    String result = response.body.replaceAll('.', '');
    return result;
  }

  Future<double> getCurrentGreenEnergyPercentage() async {
    Map generation = csvToMap(await requestData(modul: Modul.generation));
    Map forecastedGeneration =
        csvToMap(await requestData(modul: Modul.forecasted_generation));

    List renewable = [
      'Biomasse[MWh]',
      'Wasserkraft[MWh]',
      'Sonstige Erneuerbare[MWh]'
    ];
    List conventional = [
      'Kernenergie[MWh]',
      'Braunkohle[MWh]',
      'Steinkohle[MWh]',
      'Erdgas[MWh]',
      'Pumpspeicher[MWh]',
      'Sonstige Konventionelle[MWh]'
    ];
    List forecastedRenewable = [
      "Wind Offshore[MWh]",
      "Wind Onshore[MWh]",
      "Photovoltaik[MWh]"
    ];
    double ePowerGen = 0.0;
    double kPowerGen = 0.0;

    renewable.forEach((index) {
      double energy;
      List gen = generation[index];
      for (int i = 1; i < gen.length; i++) {
        if (gen[gen.length - i] != "-") {
          energy = gen[gen.length - i].toDouble();
          break;
        }
      }
      print('$index: $energy');
      ePowerGen += energy;
    });
    forecastedRenewable.forEach((index) {
      double energy = (forecastedGeneration[index].last).toDouble();
      print('$index: $energy');
      ePowerGen += energy;
    });
    conventional.forEach((index) {
      double energy;
      List gen = generation[index];
      for (int i = 1; i < gen.length; i++) {
        if (gen[gen.length - i] != "-") {
          energy = gen[gen.length - i].toDouble();
          break;
        }
      }
      print('$index: $energy');
      kPowerGen += energy;
    });

    print('e: $ePowerGen');
    print('k: $kPowerGen');

    double percentage = double.parse(
        (ePowerGen / (ePowerGen + kPowerGen) * 100).toStringAsFixed(1));

    return percentage;
  }
}

enum Modul {
  price,
  consumption,
  generation,
  forecasted_generation,
}
