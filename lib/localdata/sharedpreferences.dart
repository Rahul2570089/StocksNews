import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _tokenkey = 'token';
  static const _keyS = 'watchlistsymbol';
  static const _keyC = 'watchlistcolor';
  static const _keyS1 = 'watchlistsymbol1';
  static const _keyC1 = 'watchlistcolor1';
  static const _key4 = 'name1';
  static const _key5 = 'symbol1';
  static const _key2 = 'name';
  static const _key3 = 'symbol';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setToken(String token) async {
    await _preferences?.setString(_tokenkey, token);
  }

  static String? getToken() {
    return _preferences?.getString(_tokenkey);
  }

  static Future setSymbol(RxList<String> s) async {
    await _preferences?.setStringList(_keyS, s);
  }

  static Future setSymbol1(RxList<String> s) async {
    await _preferences?.setStringList(_keyS1, s);
  }

  static Future setColor(RxList<String> s) async {
    await _preferences?.setStringList(_keyC, s);
  }

  static Future setColor1(RxList<String> s) async {
    await _preferences?.setStringList(_keyC1, s);
  }

  static List<String>? getSymbol() {
    return _preferences?.getStringList(_keyS);
  }

  static List<String>? getSymbol1() {
    return _preferences?.getStringList(_keyS1);
  }

  static List<String>? getColor() {
    return _preferences?.getStringList(_keyC);
  }

  static List<String>? getColor1() {
    return _preferences?.getStringList(_keyC1);
  }

  static Future setWatchlistName(RxList<String> n) async {
    return _preferences?.setStringList(_key2, n);
  }

  static List<String>? getWatchlistName() {
    return _preferences?.getStringList(_key2);
  }

  static Future setWatchlistName1(RxList<String> s) async {
    await _preferences?.setStringList(_key4, s);
  }

  static List<String>? getWatchlistName1() {
    return _preferences?.getStringList(_key4);
  }

  static Future setWatchlistSymbol(RxList<String> s) async {
    return _preferences?.setStringList(_key3, s);
  }

  static List<String>? getWatchlistSymbol() {
    return _preferences?.getStringList(_key3);
  }

  static Future setWatchlistSymbol1(RxList<String> s) async {
    return _preferences?.setStringList(_key5, s);
  }

  static List<String>? getWatchlistSymbol1() {
    return _preferences?.getStringList(_key5);
  }
}
