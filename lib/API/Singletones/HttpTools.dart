import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpTools {
  static Future<String> getRequestAsync(String url) async {
    var response = await http.get(url, headers: {"Accept": "application/json"});

    return response.body;
  }

  static Future<List> getJsonListAsync(String url) async {
    var stringResponse = await getRequestAsync(url);

    List decodedData = json.decode(stringResponse);

    return decodedData;
  }

  static Future<List> getProductInfoAsync(int offset, int limit) async {
    var data = await getJsonListAsync(
        "http://mobile-test.devebs.net:5000/products?offset=$offset&limit=$limit");

    return data;
  }
}
