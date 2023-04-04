import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/auth/createuser_page.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  await UserSimplePreferences.init();
  runApp(const MaterialApp(
    home: CreateUserPage(),
    debugShowCheckedModeBanner: false,
    title: 'StockOps-INDIAN STOCKS AND NEWS',
  ));
}
