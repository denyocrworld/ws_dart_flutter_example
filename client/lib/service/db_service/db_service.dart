import 'package:shared_preferences/shared_preferences.dart';

class DBService {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future set(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String? get(String key) {
    return prefs.getString(key);
  }

  static remove(String key) async {
    await prefs.remove(key);
  }
}
