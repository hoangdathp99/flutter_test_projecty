import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
}

Future<String> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token") ?? "";
}

Future<bool> removeData() async {
  final prefs = await SharedPreferences.getInstance();
  final success = await prefs.remove('token');
  // print(success);
  return success;
}
