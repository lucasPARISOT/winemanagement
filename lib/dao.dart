import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

/// This the class for all incoming and outgoing data
class DAO {

  Future<void> addWine() async {

    const Map<String, String> _JSON_HEADERS = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods' : 'POST'
    };

    final uri = Uri.http('localhost:3000', 'wine');

    // Testing data
    const String data = '''
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

    final http.Client client = http.Client();
    client.post(uri, body: data, headers: _JSON_HEADERS);
  }

  Future<dynamic> getAllWines() async {

    final uri = Uri.http('localhost:3000', 'test');

    final http.Response response = await http
        .get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = convert.jsonDecode(
          convert.utf8.decode(
              response.bodyBytes
          )
      );
      final desc = jsonResponse;
      return desc;
    } else {
      throw Exception('Failed to load wineAPI');
    }
  }
}