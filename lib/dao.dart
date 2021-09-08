import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DAO {

  void addWine() async {

    const Map<String, String> _JSON_HEADERS = {
      "content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods" : "POST"
    };

    var uri = Uri.http("localhost:3000", "wine");

    // Testing data
    String data = '''
      {
        "image":"none",
        "desc":"Un bon vin",
        "cepage":"Un cepage",
        "millesime":1998,
        "type":"Vin blanc",
        "domaine":"Domaine du Vin",
        "lieu":"Un lieu",
        "quantite":1
      }
      ''';

    http.Client client = new http.Client();
    client.post(uri, body: data, headers: _JSON_HEADERS);
  }

  Future<dynamic> getAllWines() async {

    var uri = Uri.http("localhost:3000", "test");

    http.Response response = await http
        .get(uri);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      var desc = jsonResponse;

      //print(desc);

      return desc;
    } else {
      throw Exception('Failed to load wineAPI');
    }
  }
}