import 'dart:convert';

import 'package:newsapp/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/auth/config.dart';

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
        return User(email, password);
      } else {
        return User(null, null);
      }
    } catch (e) {
      return User(null, null);
    }
  }

  static Future<String> logoutUser(String email) async {
    try {
      var user = {"email": email};
      var response = await http.post(Uri.parse(logout),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user));

      var jsonResponse = jsonDecode(response.body.toString());

      if (jsonResponse['status']) {
        return 'success';
      } else {
        return 'fail';
      }
    } catch (e) {
      return 'fail';
    }
  }
}
