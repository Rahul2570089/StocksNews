import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/Models/article.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';

class BSEcontroller extends GetxController {
  var n = <String>[].obs;
  var s = <String>[].obs;
  var m = <String, String>{}.obs;
  var showsymbol = <String>[].obs;
  var showcolor = <String>[].obs;
  var list = <Article>[].obs;
  var list2 = <Article>[].obs;
  var show = false.obs;
  var c = TextEditingController().obs;
  var mapresponse = [].obs;
  var tabController = [].obs;

  void removeFromWatchlist(List stocks, int position) async {
    int a = n.indexOf(stocks[position].name! == ''
        ? '  Name Unavailable  '
        : '  ' + stocks[position].name! + '  ');
    n.removeAt(a);
    int b = s.indexOf(stocks[position].symbol!);
    s.removeAt(b);
    m[stocks[position].symbol!] = 'false';
    m.forEach((key, value) {
      showsymbol.add(key);
    });
    m.forEach((key, value) {
      showcolor.add(value);
    });
    await UserSimplePreferences.setSymbol1(showsymbol);
    await UserSimplePreferences.setColor1(showcolor);
    await UserSimplePreferences.setWatchlistName1(n);
    await UserSimplePreferences.setWatchlistSymbol1(s);
  }

  void addToWatchlist(List stocks, int position) async {
      s.add(stocks[position].symbol!);
      n.add(
        stocks[position].name! == ''
            ? '  Name Unavailable  '
            : '  ' + stocks[position].name! + '  ',
      );
      m[stocks[position].symbol!] = 'true';
    m.forEach((key, value) {
      showsymbol.add(key);
    });
    m.forEach((key, value) {
      showcolor.add(value);
    });
    await UserSimplePreferences.setSymbol1(showsymbol);
    await UserSimplePreferences.setColor1(showcolor);
    await UserSimplePreferences.setWatchlistName1(n);
    await UserSimplePreferences.setWatchlistSymbol1(s);
  }
}
