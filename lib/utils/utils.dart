import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveData(String key, String token) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setString(key, token);
}

Future<String> loadData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? "";
}

Future<bool> removeData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final success = await prefs.remove(key);
  // print(success);
  return success;
}

String capitalize(String str) {
  if (str != '') {
    return str.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return word;
      }
    }).join(' ');
  } else {
    return str;
  }
}
