import 'package:shared_preferences/shared_preferences.dart';

class SaveService {
  static Future<void> retrieve() async {
    final prefs = await SharedPreferences.getInstance();

    // Check where the Ip is saved before or not
    if (!prefs.containsKey('indexName')) {
      return;
    }
    // varname =  prefs.getString('indexName')!;
  }

  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('indexName', "value");
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('indexName', "");
  }
}
