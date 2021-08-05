import 'dart:convert';

import 'package:http/http.dart' as http;

class DAO {

  void insertTest(int number) async {

    const Map<String, String> _JSON_HEADERS = {
      "content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods" : "GET, POST"
    };

    var uri = Uri.http("localhost:3000", "test");

    String data = '''{"test":"YES IT IS WORKING !","counter":$number}''';

    http.Client client = new http.Client();
    client.post(uri, body: data, headers: _JSON_HEADERS);
  }

}