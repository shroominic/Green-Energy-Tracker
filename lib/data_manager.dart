import 'package:flutter/material.dart';
import 'scraper.dart' as scraper;

class DataManager {
  Future<void> init() async {
    gePercentage = await greenEnergyPercentage(DateTimeRange(
        start: DateTime.now().subtract(Duration(days: 1)),
        end: DateTime.now()));
  }

  Map<DateTime, double> gePercentage;

  Future<double> get greenEnergy24minimum async {
    if (gePercentage == null) {
      await init();
    }
    double result = 100;
    gePercentage.forEach((key, value) {
      if (value < result) result = value;
    });
    return result;
  }

  Future<double> get greenEnergy24maximum async {
    if (gePercentage == null) {
      await init();
    }
    double result = 0;
    gePercentage.forEach((key, value) {
      if (value > result) result = value;
    });
    return result;
  }

  Future<double> get currentGreenEnergyPercentage async {
    if (gePercentage == null) {
      await init();
    }
    double result;
    gePercentage.forEach((key, value) {
      result = value;
    });
    return result;
  }

  Future<Map<DateTime, double>> greenEnergyPercentage(
      DateTimeRange dateTimeRange) async {
    Map<DateTime, double> result = Map<DateTime, double>();
    DateTimeRange scraperRange = DateTimeRange(
        start: DateTime.now().subtract(Duration(hours: 1)),
        end: DateTime.now());
    // minimum request dateTimeRange
    if (dateTimeRange.duration > Duration(days: 1))
      scraperRange = dateTimeRange;

    Map request =
        await scraper.requestGenerationDataAndFillMissing(scraperRange);

    List renewable = [
      'Biomasse[MWh]',
      'Wasserkraft[MWh]',
      'Sonstige Erneuerbare[MWh]',
      "Wind Offshore[MWh]",
      "Wind Onshore[MWh]",
      "Photovoltaik[MWh]"
    ];
    List conventional = [
      'Kernenergie[MWh]',
      'Braunkohle[MWh]',
      'Steinkohle[MWh]',
      'Erdgas[MWh]',
      'Pumpspeicher[MWh]',
      'Sonstige Konventionelle[MWh]'
    ];

    // parse String date to DateTime objects
    //request['Uhrzeit'].forEach((uhrzeit)
    for (int i = 0; i < request['Uhrzeit'].length; i++) {
      DateTime date =
          DateTime.parse('${request['Datum'][i]} ${request['Uhrzeit'][i]}');
      double ePowerGen = 0.0;
      double kPowerGen = 0.0;
      renewable.forEach((element) {
        ePowerGen += (request[element][i]).toDouble();
      });
      conventional.forEach((element) {
        kPowerGen += (request[element][i]).toDouble();
      });

      double percentage = double.parse(
          (ePowerGen / (ePowerGen + kPowerGen) * 100).toStringAsFixed(1));

      result.putIfAbsent(date, () => percentage);
    }
    return result;
  }
}
