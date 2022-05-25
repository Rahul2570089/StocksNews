import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyS = 'watchlistsymbol';
  static const _keyC = 'watchlistcolor';
  static const _key2 = 'name';
  static const _key3 = 'symbol';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setSymbol(List<String> s) async {
    await _preferences?.setStringList(_keyS, s);
  }

  static Future setColor(List<String> s) async {
    await _preferences?.setStringList(_keyC, s);
  }

  static List<String>? getSymbol() {
    return _preferences?.getStringList(_keyS);
  }

  static List<String>? getColor() {
    return _preferences?.getStringList(_keyC);
  }

  static Future setWatchlistName(List<String> n) async {
    return _preferences?.setStringList(_key2, n);
  }

  static List<String>? getWatchlistName() {
    return _preferences?.getStringList(_key2);
  }

  static Future setWatchlistSymbol(List<String> s) async {
    return _preferences?.setStringList(_key3, s);
  }

  static List<String>? getWatchlistSymbol() {
    return _preferences?.getStringList(_key3);
  }
}
