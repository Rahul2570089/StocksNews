import 'dart:convert';

import 'package:newsapp/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/auth/config.dart';

class CreateUser {
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

      print(jsonResponse);
      if (jsonResponse['status']) {
        return User(email, password);
      } else {
        print(jsonResponse['message']);
        return User(null, null);
      }
    } catch (e) {
      print(e);
      return User(null, null);
    }
  }
}
