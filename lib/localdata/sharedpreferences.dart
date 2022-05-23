import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _key = 'username';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setColor(List<String> s) async {
    await _preferences?.setStringList(_key, s);
  }

  static List<String>? getColor() {
    return _preferences?.getStringList(_key);
  }

}