import 'dart:convert';

import 'package:http/http.dart' as http;

class Apivalues {
  Future<dynamic> userLogin(String email, String passWord) async {
    try {
      var userLoginApi =
          "https://dealsdraybackend.onrender.com/api/admin/login";
      var data = {
        "email": email,
        "password": passWord,
      };

      var response = await http.post(Uri.parse(userLoginApi),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> userSignUp(String name, String email, String passWord) async {
    try {
      var userSignUpAPI =
          "https://dealsdraybackend.onrender.com/api/admin/signup";
      var data = {
        "name": name,
        "email": email,
        "password": passWord,
      };

      var response = await http.post(Uri.parse(userSignUpAPI),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

var apiValues = Apivalues();
