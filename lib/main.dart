import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:newsapp/auth/createuser_page.dart';
import 'package:newsapp/homepage.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  await UserSimplePreferences.init();
  runApp(MaterialApp(
    home: ((UserSimplePreferences.getToken() == null ||
                UserSimplePreferences.getToken() == '') ||
            JwtDecoder.isExpired(UserSimplePreferences.getToken()!))
        ? const CreateUserPage()
        : HomePage(token: UserSimplePreferences.getToken()!),
    debugShowCheckedModeBanner: false,
    title: 'StockOps-INDIAN STOCKS AND NEWS',
  ));
}
