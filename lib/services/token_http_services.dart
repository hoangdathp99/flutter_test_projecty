import 'dart:convert';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:http/http.dart' as http;

Future<dynamic> get(String url, String param) async {
  String token = await loadData();
  try {
    final response = await http.get(Uri.parse(url + param),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data');
  }
}
