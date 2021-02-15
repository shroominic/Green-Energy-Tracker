import 'package:http/http.dart';
import 'dart:convert';

class SmardAPI {
  Client client;

  var url =
      "https://www.smard.de/nip-download-manager/nip/download/market-data";

  SmardAPI() {
    client = Client();
  }

  String jsonRequestForm() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    Map<String, List<Map<String, dynamic>>> json = {
      "request_form": [
        {
          "format": "CSV",
          "moduleIds": [8004169],
          "region": "DE",
          "timestamp_from": timestamp - 6 * 3600000,
          "timestamp_to": timestamp,
          "type": "discrete",
          "language": "de"
        }
      ]
    };
    return jsonEncode(json);
  }

  Future<String> getData() async {
    Response response = await client.post(url, body: jsonRequestForm());
    print(response.headers);
    return response.body;
  }
}
