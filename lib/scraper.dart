import 'package:http/http.dart';
import 'dart:convert';
import 'package:df/df.dart';

class SmardData {
  SmardData();

  Future<String> requestData(
      {int fromInHoursAgoNow = 5,
      int toInHoursAfterNow = 0,
      Modul modul = Modul.price}) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    var url =
        "https://www.smard.de/nip-download-manager/nip/download/market-data";

    List modules;
    switch (modul) {
      case Modul.consumption:
        modules = [6000411, 6004362];
        break;
      case Modul.price:
        modules = [8004169];
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

    return response.body;
  }

  //int getCurrentGreenEnergyPercentage() {}
}

enum Modul {
  price,
  consumption,
}
