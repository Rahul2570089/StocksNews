import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Models/article2.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';

class NSEcontroller extends GetxController {
  var n = <String>[].obs;
  var s = <String>[].obs;
  var m = <String, String>{}.obs;
  var showsymbol = <String>[].obs;
  var showcolor = <String>[].obs;
  var list = <Article2>[].obs;
  var list2 = <Article2>[].obs;
  var show = false.obs;
  var c = TextEditingController().obs;
  var mapresponse = [].obs;
  var tabController = [].obs;

  void removeFromWatchlist(List<Article2> stocks, int position) async {
    int a = n.indexOf(stocks[position].name! == ''
        ? '  Name Unavailable  '
        : '  ' + stocks[position].name! + '  ');
    n.removeAt(a);
    int b = s.indexOf(stocks[position].symbol!);
    s.removeAt(b);
    m[stocks[position].symbol!] = 'false';
    await UserSimplePreferences.setSymbol(showsymbol);
    await UserSimplePreferences.setColor(showcolor);
    await UserSimplePreferences.setWatchlistName(n);
    await UserSimplePreferences.setWatchlistSymbol(s);
  }

  void addToWatchlist(List<Article2> stocks, int position) async {
    n.add(stocks[position].name! == ''
        ? '  Name Unavailable  '
        : '  ' + stocks[position].name! + '  ');
    s.add(stocks[position].symbol!);
    m[stocks[position].symbol!] = 'true';
    m.forEach((key, value) {
      showsymbol.add(key);
    });
    m.forEach((key, value) {
      showcolor.add(value);
    });
    await UserSimplePreferences.setSymbol(showsymbol);
    await UserSimplePreferences.setColor(showcolor);
    await UserSimplePreferences.setWatchlistName(n);
    await UserSimplePreferences.setWatchlistSymbol(s);
  }
}
