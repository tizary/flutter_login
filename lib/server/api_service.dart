import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/network_util.dart';

class ApiService {
  final String baseUrl = 'https://api.unsplash.com';
  final String photoEndpoint = '/photos';
  final String authKey =
      'client_id=onj95i1jbk6R5835QFEVXJgl2yCEEHew9WMiu3U7pY4';

  Future getPhotos() async {
    if(!await NetworkUtil.hasConnection()) {
      return null;
    }
    try {
      var url = Uri.parse('$baseUrl$photoEndpoint?$authKey');
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
