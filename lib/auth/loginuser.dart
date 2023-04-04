import 'dart:convert';

import 'package:newsapp/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/auth/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUser {
  static Future<User> loginUser(String email, String password) async {
    var reqBody = {"email": email, "password": password};

    var response = await http.post(Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      var myToken = jsonResponse['token'];
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('token', myToken);
      });
      return User(email, password);
    } else {
      return User(null, null);
    }
  }
}
