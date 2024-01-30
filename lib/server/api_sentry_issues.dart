import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/network_util.dart';

class ApiSentryIssues {
  static const apiUrl =
      'https://sentry.io/api/0/projects/tizary/flutter/issues/';
  static const apiToken =
      '6684b916a76a5a1cbfb53d8817b911786a9794a9fdf25e692c89318a2706d468';

  static Future getIssues() async {
    if (!await NetworkUtil.hasConnection()) {
      return null;
    }
    var url = Uri.parse(apiUrl);
    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $apiToken'});
      if (response.statusCode == 200) {
        List events = jsonDecode(response.body);
        return events;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Request to sentry failed: $e');
    }
  }
}
