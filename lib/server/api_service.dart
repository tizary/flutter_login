import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.unsplash.com';
  final String photoEndpoint = '/photos';
  final String authKey =
      'client_id=onj95i1jbk6R5835QFEVXJgl2yCEEHew9WMiu3U7pY4';

  Future getPhotos() async {
    try {
      var url = Uri.parse(baseUrl + photoEndpoint + '?' + authKey);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }
}
