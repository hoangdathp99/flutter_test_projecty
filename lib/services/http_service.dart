import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchData(
    String url, String unencodedPath, Map<String, String> param) async {
  try {
    final response = await http.get(Uri.https(url, unencodedPath, param));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data');
  }
}

Future<dynamic> post(String url, body) async {
  try {
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201) {
      return (json.decode(response.body));
      // return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<dynamic> put(String url, body) async {
  try {
    final response = await http.put(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data');
  }
}
