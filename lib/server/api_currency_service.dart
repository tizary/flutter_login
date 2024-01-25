import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/network_util.dart';

class ApiCurrencyService {
  static const String baseUrl = 'https://api.nbrb.by/exrates/rates';
  static const String dateEndpoint = '?ondate=';
  static const String currencyEndpoint = '&periodicity=0';

  static Future getCurrencyRates(String date) async {
    if(!await NetworkUtil.hasConnection()) {
      return null;
    }
    try {
      var url = Uri.parse(baseUrl + dateEndpoint + date + currencyEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Request failed: $e');

    }
  }
}
