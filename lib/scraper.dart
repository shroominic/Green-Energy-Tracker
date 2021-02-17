import 'package:http/http.dart';
import 'dart:convert';

Future<String> getData() async {
  var time = DateTime.now().millisecondsSinceEpoch;
  var url =
      "https://www.smard.de/nip-download-manager/nip/download/market-data";
  var body = json.encode({
    "request_form": [
      {
        "format": "CSV",
        "moduleIds": [6000411, 6004362],
        "region": "DE",
        "timestamp_from": time - Duration(hours: 1).inMilliseconds,
        "timestamp_to": time,
        "type": "discrete",
        "language": "de"
      }
    ]
  });

  Response response = await post(url,
      body: body, headers: {"Content-Type": "application/json"});
  print("\n${response.contentLength} \n ${response.headers} \n");
  return response.body;
}
