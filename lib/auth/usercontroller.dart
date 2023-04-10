import 'dart:convert';

import 'package:newsapp/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/auth/config.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';

class UserController {
  static Future<User> createUser(String email, String password) async {
    try {
      var user = {
        "email": email,
        "password": password,
      };

      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user));

      var jsonResponse = jsonDecode(response.body.toString());

      if (jsonResponse['status']) {
        UserSimplePreferences.setToken(jsonResponse['token']);
        return User(email, password);
      } else {
        return User(null, null);
      }
    } catch (e) {
      return User(null, null);
    }
  }

  static Future<User> loginUser(String email, String password) async {
    try {
      var user = {
        "email": email,
        "password": password,
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user));

      var jsonResponse = jsonDecode(response.body.toString());

      if (jsonResponse['status']) {
        UserSimplePreferences.setToken(jsonResponse['token']);
        return User(email, password);
      } else {
        return User(null, null);
      }
    } catch (e) {
      return User(null, null);
    }
  }

  static void logoutUser(String email) {
    UserSimplePreferences.setToken('');
  }
}
